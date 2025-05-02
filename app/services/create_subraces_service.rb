class CreateSubracesService
  FILE_PATH = './lib/json/Subraces.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Subrace...'
    @data.each do |subrace_data|
      race = Race.find_or_create_by!(name:subrace_data['race']['name'])
      subrace = Subrace.find_or_create_by!(name: subrace_data['name'], race: race)

      subrace.update_columns(
        description: subrace_data['desc']
      )

      subrace.save!

      handle_starting_proficiencies(subrace, subrace_data)
      handle_ability_bonus(subrace, subrace_data)
      handle_traits(subrace, subrace_data)
      handle_language_choices(subrace, subrace_data)
    end
  end
  
  private

  def handle_starting_proficiencies(subrace, subrace_data)
    return if subrace_data.empty?

    subrace_data['starting_proficiencies'].map do |proficiency_data|
      proficiency = Proficiency.find_by(name: proficiency_data['name'])
      SubraceProficiency.find_or_create_by(
        subrace: subrace,
        proficiency: proficiency
      )
    end
  end

  def handle_ability_bonus(subrace, subrace_data)
    subrace_data['ability_bonuses'].each do |ability_bonus_data|
      ability_score = AbilityScore.find_by(name: ability_bonus_data['ability_score']['name'])

      SubraceAbilityBonus.create!(
        subrace: subrace,
        ability_score: ability_score
      )
    end

    subrace.save!
  end

  def handle_traits(subrace, subrace_data)
    return if subrace_data['racial_traits'].empty?

    subrace_data['racial_traits'].each do |trait_data|
      trait = Trait.find_by(name: trait_data['name'])

      TraitSubrace.find_or_create_by(subrace: subrace, trait: trait)
    end
  end

  def handle_language_choices(subrace, subrace_data)
    return if subrace_data["language_options"].nil?

    language_options_data = subrace_data["language_options"]

    language_choice = SubraceLanguageChoice.create!(
      choose: language_options_data['choose'],
      subrace: subrace
    )

    language_options_data['from']['options'].each do |language_data|
      language = Language.find_by(name: language_data['item']['name'])
      SubraceLanguageChoiceOption.create!(
        subrace_language_choice: language_choice,
        language: language
      )
    end

    subrace.save!
  end
end
