class TraitSpecificDamageBreath < ApplicationRecord
  belongs_to :trait
  belongs_to :damage_type, class_name: 'DamageType'
  belongs_to :saving_throw, class_name: 'SavingThrow'

  # Parses the JSONB data for damage at specific character levels
  def damage_at_level(level)
    damage_at_character_level[level.to_s] # Returns damage string, e.g., "2d6"
  end

  # Returns all levels and their associated damage as a hash
  def all_damage_levels
    damage_at_character_level || {}
  end
end
