class Character < ApplicationRecord
  include Dnd::CharacterProgression

  ABILITY_SCORE_MAP = {
    STR: :strength,
    DEX: :dexterity,
    CON: :constitution,
    INT: :intelligence,
    WIS: :wisdom,
    CHA: :charisma
  }.freeze

  belongs_to :user
  belongs_to :alignment, optional: true
  belongs_to :background, optional: true
  belongs_to :race, optional: true
  belongs_to :subrace, optional: true

  has_one_attached :avatar
  has_one_attached :token

  with_options dependent: :destroy do
    has_many :character_skills
    has_one :character_inventory
    has_one :ability_scores, class_name: "CharacterAbilityScore"
    has_one :character_physical_characteristic
    has_one :character_note
  end

  has_many :inventory_items, through: :character_inventory

  has_many :subrace_proficiencies, through: :subrace
  has_many :background_proficiencies, through: :background
  has_many :race_proficiencies, through: :race
  has_many :class_proficiencies, through: :klasses
  has_many :race_ability_bonus, through: :race

  has_many :racial_traits, through: :race, source: :traits
  has_many :subracial_traits, through: :subrace, source: :traits

  delegate :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma,
           to: :ability_scores, allow_nil: true

  after_create :create_ability_scores

  def level
    total_level
  end

  def modifier(ability)
    score = ability_scores&.public_send(ability.to_s)
    return nil unless score

    ((score - 10) / 2.0).floor
  end

  def active_features
    class_progressions.flat_map(&:available_features).uniq
  end

  def proficiencies
    [race_proficiencies, subrace_proficiencies, background_proficiencies, class_proficiencies]
      .flatten
      .compact
      .uniq
  end

  def starting_equipments
    klasses.includes(:starting_equipment).flat_map(&:starting_equipment)
  end

  def klasses_name
    # remove the default ORDER BY that references character_classes.level
    klasses.reorder(nil).pluck(:name).uniq.join(', ')
  end

  def traits
    (racial_traits + subracial_traits).uniq
  end

  def klass
    primary_class || klasses.reorder(nil).first
  end

  def character_attribute_names
    ABILITY_SCORE_MAP
  end

  def ability_for(short_code)
    ability_key = ABILITY_SCORE_MAP[short_code.to_s.upcase.to_sym]
    return unless ability_key

    ability_scores&.public_send(ability_key)
  end

  def token_thumbnail
    if klass
      "#{klass.name.downcase}.png"
    else
      "default_class.png"
    end
  end

  private

  def create_ability_scores
    build_ability_scores.save!
  end
end
