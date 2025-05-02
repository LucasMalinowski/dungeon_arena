class Monster < ApplicationRecord
  has_many :monster_special_abilities, dependent: :destroy
  has_many :monster_actions, dependent: :destroy
  has_many :monster_legendary_actions, dependent: :destroy
  has_many :monster_reactions, dependent: :destroy

  has_many :monster_damage_vulnerabilities, dependent: :destroy
  has_many :damage_vulnerabilities, through: :monster_damage_vulnerabilities, source: :damage_type

  has_many :monster_damage_resistances, dependent: :destroy
  has_many :damage_resistances, through: :monster_damage_resistances, source: :damage_type

  has_many :monster_damage_immunities, dependent: :destroy
  has_many :damage_immunities, through: :monster_damage_immunities, source: :damage_type

  has_many :monster_condition_immunities, dependent: :destroy
  has_many :condition_immunities, through: :monster_condition_immunities, source: :condition

  before_save :normalize_armor_class


  # Fetch all armor class types
  def armor_class_types
    armor_class.map { |entry| entry["type"] }
  end

  # Get armor class value for a specific type
  def armor_class_value(type)
    entry = armor_class.find { |ac| ac["type"] == type }
    entry["value"] if entry
  end

  # Pretty description for display
  def armor_class_description
    armor_class.map do |entry|
      desc = "#{entry['type'].capitalize}: #{entry['value']}"
      if entry["details"]
        desc += " (#{entry['details']})"
      end
      desc
    end.join(", ")
  end

  private

  def normalize_armor_class
    return unless armor_class.is_a?(Hash)

    normalized = armor_class.map do |key, details|
      {
        "type" => key,
        "value" => details["value"],
        "details" => details.except("value")
      }.compact
    end
    self.armor_class = normalized
  end

end
