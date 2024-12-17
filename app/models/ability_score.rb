class AbilityScore < ApplicationRecord
  has_many :saving_throws
  has_many :race_ability_bonuses, class_name: "RaceAbilityBonus", dependent: :destroy
  has_many :subrace_ability_bonuses, class_name: "SubraceAbilityBonus",dependent: :destroy
  has_many :race_ability_bonus_choice_options, class_name: "RaceAbilityBonusChoiceOption", dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :full_name, presence: true, uniqueness: true
end
