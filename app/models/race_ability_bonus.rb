class RaceAbilityBonus < ApplicationRecord
  belongs_to :race
  belongs_to :ability_score
end
