class CreateTraitsService
  FILE_PATH = './lib/json/Traits.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    puts 'Creating Traits...'

    @data.each do |trait_data|
      trait = Trait.find_or_create_by!(name: trait_data['name']) do |t|
        t.description = trait_data['desc']
      end

      create_subraces_associations(trait, trait_data['subraces'])
      create_race_associations(trait, trait_data['races'])
      create_proficiency_associations(trait, trait_data['proficiencies'])
    end

  end

  private

  def create_subraces_associations(proficiency, subrace_data)
    return if subrace_data.blank?

    subrace_data.each do |klass_data|
      klass = Klass.find_or_create_by!(name: klass_data['name'])
      ClassProficiency.find_or_create_by!(klass: klass, proficiency: proficiency)
    end
  end

  def create_race_associations(proficiency, races_data)
    return if races_data.blank?

    races_data.each do |race_data|
      if race_data['url'].contains?('subraces')
        sub_race = Subrace.find_or_create_by!(name: race_data['name'])
        RaceProficiency.find_or_create_by!(race: sub_race, proficiency: proficiency)
      else
        race = Race.find_or_create_by!(name: race_data['name'])
        RaceProficiency.find_or_create_by!(race: race, proficiency: proficiency)
      end
    end
  end
end
