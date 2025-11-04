class CharacterAbilityScore < ApplicationRecord
  ABILITY_SCORES = %i[strength dexterity constitution intelligence wisdom charisma].freeze

  belongs_to :character

  def [](ability_name)
    public_send(ability_name.to_s)
  end

  def modifier_for(ability_name)
    score = self[ability_name]
    return nil unless score

    ((score - 10) / 2.0).floor
  end

  def total_modifier(ability_score)
    modifier_for(ability_score)
  end
end
