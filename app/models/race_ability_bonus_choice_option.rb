class RaceAbilityBonusChoiceOption < ApplicationRecord
  belongs_to :race_ability_bonus_choice
  belongs_to :ability_score
end
