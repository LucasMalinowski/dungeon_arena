class CreateProficienciesService
  FILE_PATH = './lib/json/Proficiencies.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    puts 'Creating Proficiencies...'

    @data.each do |proficiency_data|
      proficiency = Proficiency.find_or_create_by!(name: proficiency_data['name'])

      create_class_associations(proficiency, proficiency_data['classes'])
      create_race_associations(proficiency, proficiency_data['races'])
    end

  end

  private

  def create_class_associations(proficiency, classes_data)
    return if classes_data.blank?

    classes_data.each do |klass_data|
      klass = Klass.find_or_create_by!(name: klass_data['name'])
      ClassProficiency.find_or_create_by!(klass: klass, proficiency: proficiency)
    end
  end

  def create_race_associations(proficiency, races_data)
    return if races_data.blank?

    races_data.each do |race_data|
      if race_data['url'].include?('subraces')
        sub_race = Subrace.find_or_create_by!(name: race_data['name'])
        SubraceProficiency.find_or_create_by!(subrace: sub_race, proficiency: proficiency)
      else
        race = Race.find_or_create_by!(name: race_data['name'])
        RaceProficiency.find_or_create_by!(race: race, proficiency: proficiency)
      end
    end
  end
end
