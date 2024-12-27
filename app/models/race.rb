class Race < ApplicationRecord
  has_many :race_proficiencies
  has_many :proficiencies, through: :race_proficiencies

  has_many :race_proficiency_choices, dependent: :destroy
  has_many :proficiency_options, through: :race_proficiency_choices, source: :race_proficiency_choice_options

  has_many :trait_races
  has_many :traits, through: :trait_races

  has_many :race_ability_bonus, dependent: :destroy, class_name: 'RaceAbilityBonus'
  has_many :ability_scores, through: :race_ability_bonus

  has_many :race_ability_bonus_choices, dependent: :destroy
  has_many :ability_bonus_options, through: :race_ability_bonus_choices, source: :race_ability_bonus_choice_options

  has_many :race_languages, dependent: :destroy
  has_many :languages, through: :race_languages

  has_many :race_language_choices, dependent: :destroy
  has_many :language_options, through: :race_language_choices, source: :race_language_choice_options

  has_many :subraces, dependent: :destroy
end
