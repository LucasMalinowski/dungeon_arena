class CreateTraitsService
  FILE_PATH = './lib/json/Traits.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Traits...'
    @data.each do |trait_data|
      trait = Trait.find_or_create_by!(name: trait_data['name'])

      trait.update(
        description: trait_data['desc'].join("\n"),
        parent: handle_parent(trait_data)
      )

      associate_races(trait, trait_data['races'])
      associate_subraces(trait, trait_data['subraces'])

      handle_proficiencies(trait, trait_data['proficiencies'])
      handle_trait_specific(trait, trait_data['trait_specific'])
      handle_proficiency_choices(trait, trait_data['proficiency_choices'])
      handle_languages_choices(trait, trait_data['languages_options'])
    end
  end


  private

  def handle_parent(trait_data)
    return unless trait_data['parent']

    Trait.find_by(name: trait_data['parent']['name'])
  end

  def associate_races(trait, races_data)
    return if races_data.empty?

    races_data.each do |race_data|
      race = Race.find_by(name: race_data['name'])
      next unless race
      TraitRace.find_or_create_by!(race: race, trait: trait)
    end
  end

  def associate_subraces(trait, subraces_data)
    return if subraces_data.empty?

    subraces_data.each do |subrace_data|
      subrace = Subrace.find_by(name: subrace_data['name'])
      next unless subrace
      TraitSubrace.find_or_create_by!(subrace: subrace, trait: trait)
    end
  end

  def handle_proficiencies(trait, proficiencies)
    return if proficiencies.empty?

    proficiencies.each do |proficiency_data|
      proficiency = Proficiency.find_by(name: proficiency_data['name'])
      TraitProficiency.find_or_create_by!(trait: trait, proficiency: proficiency)
    end
  end

  def handle_trait_specific(trait, trait_specific_data)
    return if trait_specific_data.nil?

    if trait_specific_data.key?('spell_options')
      handle_spell_options(trait, trait_specific_data['spell_options'])
    elsif trait_specific_data.key?('subtrait_options')
      handle_subtrait_options(trait, trait_specific_data['subtrait_options'])
    else
      handle_damage_and_breath(trait, trait_specific_data)
    end
  end

  def handle_spell_options(trait, spell_options_data)
    trait_specific_spell = TraitSpecificSpell.create!(
      trait: trait,
      choose: spell_options_data['choose'],
    )

    spell_options_data['from']['options'].each do |spell_option_data|
      spell = Spell.find_by(name: spell_option_data['item']['name'])
      TraitSpecificSpellOption.create!(
        trait_specific_spell: trait_specific_spell,
        spell: spell
      )
    end
  end

  def handle_subtrait_options(trait, subtrait_options_data)
    trait_specific_subtrait = TraitSpecificSubtrait.create!(
      trait: trait,
      choose: subtrait_options_data['choose']
    )

    subtrait_options_data['from']['options'].each do |subtrait_option_data|
      subtrait = Trait.find_or_create_by!(name: subtrait_option_data['item']['name'])
      TraitSpecificSubtraitOption.create!(
        trait_specific_subtrait: trait_specific_subtrait,
        subtrait: subtrait
      )
    end
  end

  def handle_damage_and_breath(trait, trait_specific_data)
    ability = AbilityScore.find_by(name: trait_specific_data['breath_weapon']['dc']['dc_type']['name'])
    TraitSpecificDamageBreath.create!(
      name: "#{trait_specific_data['breath_weapon']['name']} - #{trait_specific_data['damage_type']['name']}",
      description: trait_specific_data['breath_weapon']['desc'],
      area_size: trait_specific_data['breath_weapon']['area_of_effect']['size'],
      area_type: trait_specific_data['breath_weapon']['area_of_effect']['type'],
      usage_times: trait_specific_data['breath_weapon']['usage']['times'],
      usage_type: trait_specific_data['breath_weapon']['usage']['type'],
      dc_success_type: trait_specific_data['breath_weapon']['dc']['success_type'],
      damage_at_character_level: trait_specific_data['breath_weapon']['damage'][0]['damage_at_character_level'],

      trait: trait,
      damage_type: DamageType.find_by(name: trait_specific_data['damage_type']['name']),
      saving_throw: SavingThrow.find_by(ability_score_id: ability.id),
    )
  end

  def handle_proficiency_choices(trait, proficiency_choice_data)
    return if proficiency_choice_data.nil?

    proficiency_choice = TraitProficiencyChoice.create!(
      trait: trait,
      choose: proficiency_choice_data['choose']
    )

    proficiency_choice_data['from']['options'].each do |proficiency_choice_option_data|
      proficiency = Proficiency.find_or_create_by!(name: proficiency_choice_option_data['item']['name'])
      TraitProficiencyChoiceOption.create!(
        trait_proficiency_choice: proficiency_choice,
        proficiency: proficiency
      )
    end
  end

  def handle_languages_choices(trait, languages_choice_data)
    return if languages_choice_data.nil?

    languages_choice = TraitLanguagesChoice.create!(
      trait: trait,
      choose: languages_choice_data['choose']
    )

    languages_choice_data['from']['options'].each do |language_data|
      language = Language.find_by(name: language_data['item']['name'])
      TraitLanguagesChoiceOption.create!(
        trait_languages_choice: languages_choice,
        language: language
      )
    end
  end
end
