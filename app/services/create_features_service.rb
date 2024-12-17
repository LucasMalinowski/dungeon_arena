class CreateFeaturesService
  FILE_PATH = './lib/json/Features.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Features...'
    @data.each do |feature_data|
      Feature.create(name: feature_data['name']) do |feature|
        feature.level = feature_data['level']
        feature.description = feature_data['desc'].join("\n")

        feature.klass = Klass.find_or_create_by!(name: feature_data['class']['name']) if feature_data['class']
        feature.subclass = Subclass.find_or_create_by!(name: feature_data['subclass']['name']) if feature_data['subclass']

        feature.parent = Feature.find_by(name: feature_data['parent']['name']) if feature_data['parent']

        if feature_data['prerequisites']
          handle_prerequisites(feature, feature_data)
        end

        if feature_data['feature_specific']
          if feature_data['feature_specific']['subfeature_options']
            handle_subfeature_options(feature, feature_data['feature_specific']['subfeature_options'])
          elsif feature_data['feature_specific']['expertise_options']
            handle_expertise_options(feature, feature_data['feature_specific']['expertise_options'])
          elsif feature_data['feature_specific']['invocations']
            handle_invocations(feature, feature_data['feature_specific']['invocations'])
          end
        end
      end
    end
  end

  private

  def format_name(name)
    name.split('/').last.tr('-', ' ').split.map(&:capitalize).join(' ')
  end

  def handle_prerequisites(feature, feature_data)
    feature_data['prerequisites'].each do |prerequisite|
      if prerequisite['type'] == 'spell'
        feature.feature_prerequisites << FeaturePrerequisite.create(feature: feature,
                                                                    prerequisite_type: "Spell",
                                                                    prerequisite_name: format_name(prerequisite['spell']),
                                                                    )
      elsif prerequisite['type'] == 'feature'
        feature.feature_prerequisites << FeaturePrerequisite.create(feature: feature,
                                                                    prerequisite_type: "Feature",
                                                                    prerequisite_name: format_name(prerequisite['feature']),
                                                                    )
      elsif prerequisite['type'] == 'level'
        feature.feature_prerequisites << FeaturePrerequisite.create(feature: feature,
                                                                    prerequisite_type: "Level",
                                                                    prerequisite_value: prerequisite['level']
        )
      end
    end
  end

  def handle_subfeature_options(feature, subfeature_options)
    new_subfeature = SubfeatureOption.create(feature: feature,
                                             choice_quantity: subfeature_options['choose'],
                                             choice_type: subfeature_options['type']
    )
    feature_list = []
    subfeature_options['from']['options'].each do |feature_option|
      feature_list << feature_option['item']['name']
    end

    new_subfeature.update(options_list: feature_list.join(', '))
    feature.subfeature_options << new_subfeature
  end

  def handle_expertise_options(feature, expertise_options)
    new_expertise = ExpertiseOption.create(feature: feature,
                                           choice_quantity: expertise_options['choose'],
                                           choice_type: expertise_options['type']
    )

    expertise_list = []
    expertise_options['from']['options'].each do |feature_option|
      expertise_list << feature_option['item']['name']
    end

    new_expertise.update(options_list: expertise_list.join(', '))
    feature.expertise_options << new_expertise
  end

  def handle_invocations(feature, invocations)
    invocations.each do |invocation|
      feature.invocations << Invocation.create(feature: feature,
                                               name: invocation['name']
      )
    end
  end
end

