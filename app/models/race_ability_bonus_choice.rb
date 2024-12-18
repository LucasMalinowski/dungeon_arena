class RaceAbilityBonusChoice < ApplicationRecord
  belongs_to :race
  has_many :race_ability_bonus_choice_options, dependent: :destroy
end
