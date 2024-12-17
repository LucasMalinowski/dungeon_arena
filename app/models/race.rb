class Race < ApplicationRecord
  has_many :race_proficiencies
  has_many :proficiencies, through: :race_proficiencies

  has_many :race_proficiency_choices, dependent: :destroy
  has_many :race_proficiency_choice_options, through: :race_proficiency_choices

  has_many :trait_races
  has_many :traits, through: :trait_races

  has_many :race_ability_bonus, dependent: :destroy, class_name: 'RaceAbilityBonus'
  has_many :ability_score, through: :race_ability_bonus

  has_many :race_languages, dependent: :destroy
  has_many :languages, through: :race_languages

  has_many :subraces
end
