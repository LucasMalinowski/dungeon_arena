class Character < ApplicationRecord
  belongs_to :user
  belongs_to :alignment, optional: true
  belongs_to :background, optional: true
  belongs_to :race, optional: true
  belongs_to :subrace, optional: true

  has_one_attached :avatar
  has_one_attached :token

  has_many :character_classes
  has_many :klasses, through: :character_classes
  has_many :character_skills, dependent: :destroy

  has_many :subrace_proficiencies, through: :subrace
  has_many :background_proficiencies, through: :background
  has_many :race_proficiencies, through: :race
  has_many :class_proficiencies, through: :klasses

  has_one :character_inventory, dependent: :destroy
  has_many :inventory_items, through: :character_inventory

  has_one :ability_scores, dependent: :destroy, class_name: "CharacterAbilityScore"
  has_one :character_physical_characteristic, dependent: :destroy
  has_one :character_note, dependent: :destroy

  delegate :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, to: :ability_scores

  def modifier(ability)
    (send(ability) - 10) / 2
  end

  def level
    character_classes.sum(:level)
  end

  def active_features
    character_classes.flat_map do |character_class|
      character_class.klass.available_features(level: character_class.level)
    end
  end

  def proficiencies
    [race_proficiencies, subrace_proficiencies, background_proficiencies, class_proficiencies].flatten.uniq
  end

  def starting_equipments
    klasses.flat_map(&:starting_equipment)
  end

  def klasses_name
    klasses.pluck(:name).join(", ")
  end

  def traits
    [race&.traits, subrace&.traits].flatten.compact.uniq
  end

  def klass
    klasses.first
  end

  def character_attribute_names
    {
      STR: "strength",
      DEX: "dexterity",
      CON: "constitution",
      INT: "intelligence",
      WIS: "wisdom",
      CHA: "charisma"
    }
  end

  def token_thumbnail
    if klass
      p "CCCCCC"
      "#{klass&.name.downcase}.png"
    else
      p "DDDDDD"
      "default_class.png"
    end
  end
end