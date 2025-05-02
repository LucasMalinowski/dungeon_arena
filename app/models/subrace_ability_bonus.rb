class SubraceAbilityBonus < ApplicationRecord
  belongs_to :subrace
  belongs_to :ability_score
end
