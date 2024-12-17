class CreateRacesService
  FILE_PATH = './lib/json/Races.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Race...'
    @data.each do |race_data|
      race = Race.find_or_create_by!(name: race_data['name'])

      race.update_columns(
        speed: race_data['speed'],
        alignment_description: race_data['alignment'],
        age_description: race_data['age'],
        size: race_data['size'],
        size_description: race_data['size_description'],
        language_description: race_data['language_desc']
      )

      race.save!

      handle_subraces(race, race_data)
      handle_starting_proficiencies(race, race_data)
      handle_proficiency_choices(race, race_data)
      handle_ability_bonus(race, race_data)
      handle_traits(race, race_data)
      handle_language(race, race_data)
      handle_language_choices(race, race_data)
    end
  end
  
  private

  def handle_subraces(race, race_data)
    return if race_data["subraces"].empty?

    race_data["subraces"].each do |subrace_data|
      subrace = Subrace.find_or_create_by(name: subrace_data['name'], race: race)
      race.subraces << subrace 
    end
  end

  def handle_starting_proficiencies(race, race_data)
    return if race_data.empty?

    race_data['starting_proficiencies'].map do |proficiency_data|
      proficiency = Proficiency.find_by(name: proficiency_data['name'])
      RaceProficiency.find_or_create_by(
        race: race,
        proficiency: proficiency
      )
    end
  end

  def handle_proficiency_choices(race, race_data)
    return if race_data['starting_proficiency_options'].nil?

    proficiency_choice_data = race_data['starting_proficiency_options']

    proficiency_choice = RaceProficiencyChoice.create!(
      choose: proficiency_choice_data['choose'],
      description: proficiency_choice_data['desc'],
      race: race
    )

    proficiency_choice_data['from']['options'].each do |proficiency_data|
      proficiency = Proficiency.find_by!(name: proficiency_data['item']['name'])
      RaceProficiencyChoiceOption.create!(
        race_proficiency_choice: proficiency_choice,
        proficiency: proficiency
      )
    end

    race.save!
  end

  def handle_ability_bonus(race, race_data)
    race_data['ability_bonuses'].each do |ability_bonus_data|
      ability_score = AbilityScore.find_by(name: ability_bonus_data['ability_score']['name'])

      RaceAbilityBonus.create!(
        race: race,
        ability_score: ability_score
      )
    end

    race.save!
  end

  def handle_traits(race, race_data)
    return if race_data['traits'].empty?

    race_data['traits'].each do |trait_data|
      trait = Trait.find_by(name: trait_data['name'])

      TraitRace.find_or_create_by(race: race, trait: trait)
    end
  end

  def handle_language(race, race_data)
    race_data['languages'].each do |language_data|
      language = Language.find_by(name: language_data['name'])

      race.race_languages.find_or_create_by!(race: race, language: language)
    end

    race.save!
  end

  def handle_language_choices(race, race_data)
    return if race_data["language_options"].nil?

    language_options_data = race_data["language_options"]

    language_choice = RaceLanguageChoice.create!(
      choose: language_options_data['choose'],
      race: race
    )

    language_options_data['from']['options'].each do |language_data|
      language = Language.find_by(name: language_data['item']['name'])
      RaceLanguageChoiceOption.create!(
        race_language_choice: language_choice,
        language: language
      )
    end

    race.save!
  end
end
