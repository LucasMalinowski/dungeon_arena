class CharacterAbilityScore < ApplicationRecord
  belongs_to :character

  def total_modifier(ability_score)
    (ability_score - 10) / 2
  end
end
