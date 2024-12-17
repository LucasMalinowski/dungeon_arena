class CreateBackgroundsService
  FILE_PATH = './lib/json/Backgrounds.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Backgrounds...'
    @data.each do |background_data|
      background = Background.find_or_create_by!(name: background_data['name'])

      background.update(
        feature_name: background_data['feature_name'],
        feature_description: background_data['feature_desc'],
        description: background_data['description'],
        starting_equipment: background_data['starting_equipment'],
        tool_proficiencies: background_data['tool_proficiencies'],
        language_options: background_data['language_options']
      )

      handle_proficiencies(background, background_data['starting_proficiencies'])
      handle_personality_traits(background, background_data['personality_traits'])
      handle_ideals(background, background_data['ideals'])
      handle_bonds(background, background_data['bonds'])
      handle_flaws(background, background_data['flaws'])
    end
  end

  private

  def handle_personality_traits(background, personality_trait_data)
    return if personality_trait_data.nil?

    choice = BackgroundPersonalityTraitChoice.create!(background: background, choose: personality_trait_data['choose'])
    personality_trait_data['from']['options'].each do |option_data|
      BackgroundPersonalityTraitChoiceOption.create!(
        background_personality_trait_choice: choice,
        description: option_data['string']
      )
    end
  end

  def handle_ideals(background, ideal_data)
    return if ideal_data.nil?

    choice = BackgroundIdealChoice.create!(background: background, choose: ideal_data['choose'])
    ideal_data['from']['options'].each do |option_data|
      option = BackgroundIdealChoiceOption.create!(
        background_ideal_choice: choice,
        description: option_data['desc']
      )
      option_data['alignments'].each do |alignment|
        p alignment
        BackgroundIdealOptionAlignment.create!(
          background_ideal_choice_option: option,
          alignment: Alignment.find_by(name: alignment['name'])
        )
      end
    end
  end

  def handle_bonds(background, bond_data)
    return if bond_data.nil?

    choice = BackgroundBondChoice.create!(background: background, choose: bond_data['choose'])
    bond_data['from']['options'].each do |option_data|
      BackgroundBondChoiceOption.create!(
        background_bond_choice: choice,
        description: option_data['string']
      )
    end
  end

  def handle_flaws(background, flaw_data)
    return if flaw_data.nil?

    choice = BackgroundFlawChoice.create!(background: background, choose: flaw_data['choose'])
    flaw_data['from']['options'].each do |option_data|
      BackgroundFlawChoiceOption.create!(
        background_flaw_choice: choice,
        description: option_data['string']
      )
    end
  end

  def handle_proficiencies(background, proficiency_data)
    return if proficiency_data.empty?

    proficiency_data.each do |proficiency_d|
      proficiency = Proficiency.find_by(name: proficiency_d['name'])
      BackgroundProficiency.find_or_create_by!(background: background, proficiency: proficiency)
    end
  end
end
