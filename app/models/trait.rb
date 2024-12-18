class Trait < ApplicationRecord
  # Relationships with races and subraces
  has_many :trait_races, dependent: :destroy
  has_many :races, through: :trait_races

  has_many :trait_subraces, dependent: :destroy
  has_many :subraces, through: :trait_subraces

  # Relationships with proficiencies
  has_many :trait_proficiencies, dependent: :destroy
  has_many :proficiencies, through: :trait_proficiencies

  has_many :trait_proficiency_choices, dependent: :destroy
  has_many :proficiency_options, through: :trait_proficiency_choices, source: :trait_proficiency_choice_options

  # Relationships with languages
  has_many :trait_languages_choices, dependent: :destroy
  has_many :languages_options, through: :trait_languages_choices, source: :trait_languages_choice_options
  has_many :languages, through: :languages_options

  # Relationships with spell options
  has_one :trait_specific_spell, dependent: :destroy
  has_many :spell_options, through: :trait_specific_spell, source: :specific_spell_options
  has_many :spells, through: :spell_options

  has_one :trait_specific_subtrait, dependent: :destroy
  has_many :subtrait_options, through: :trait_specific_subtrait, source: :trait_specific_subtrait_options

  has_one :damage_breath, dependent: :destroy, class_name: 'TraitSpecificDamageBreath'

  belongs_to :parent, class_name: 'Trait', optional: true


  def trait_specific_type
    return :spell_options if trait_specific_spell.present?
    return :subtrait_options if trait_specific_subtrait.present?
    return :damage_and_breath if damage_breath.present?

    nil
  end

  def trait_specific_details
    case trait_specific_type
    when :spell_options
      {
        choose: trait_specific_spell.choose,
        options: spell_options.map do |option|
          { name: option.spell.name }
        end
      }
    when :subtrait_options
      {
        choose: trait_specific_subtrait.choose,
        options: subtrait_options.map do |option|
          { name: option.subtrait.name }
        end
      }
    when :damage_and_breath
      {
        name: damage_breath.name,
        description: damage_breath.description,
        damage_type: damage_breath.damage_type.name,
        area: {
          size: damage_breath.area_size,
          type: damage_breath.area_type
        },
        usage: {
          type: damage_breath.usage_type,
          times: damage_breath.usage_times
        },
        saving_throw: damage_breath.saving_throw.name,
        dc_success_type: damage_breath.dc_success_type,
        damage_at_character_level: damage_breath.damage_at_character_level
      }
    else
      {}
    end
  end
end
