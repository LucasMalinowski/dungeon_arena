class Klass < ApplicationRecord
  with_options dependent: :destroy do
    has_many :class_proficiencies
    has_many :proficiency_choices
    has_many :subclasses
    has_many :features
    has_many :spell_classes
    has_many :multiclassings
    has_many :class_saving_throws
    has_many :starting_equipment, class_name: "ClassStartingEquipment"
    has_many :class_starting_equipment_choices
    has_one  :class_spellcasting
    has_many :levels, -> { order(:level) }, inverse_of: :klass
  end

  has_many :proficiencies, -> { distinct }, through: :class_proficiencies
  has_many :proficiency_options, through: :proficiency_choices, source: :proficiency_choice_options

  has_many :spells, -> { distinct }, through: :spell_classes

  has_many :multiclassing_prerequisites, through: :multiclassings
  has_many :multiclassing_proficiencies, through: :multiclassings
  has_many :multiclassing_proficiency_choices, through: :multiclassings

  has_many :saving_throws, -> { distinct }, through: :class_saving_throws

  has_many :starting_equipment_options,
           through: :class_starting_equipment_choices,
           source: :class_starting_equipment_choice_options

  has_one :spellcasting_ability, through: :class_spellcasting
  has_many :spellcasting_infos, through: :class_spellcasting

  has_many :level_features, through: :levels
  has_many :level_specifics, through: :levels
  has_many :level_spellcasting, through: :levels

  def available_features(level:)
    levels
      .up_to(level)
      .includes(:features)
      .flat_map(&:features)
      .uniq
  end

  def saving_throws_names
    saving_throws.map do |saving_throw|
      "#{saving_throw.name}: #{saving_throw.ability_score.full_name}"
    end
  end

  def subclass_options
    subclasses.order(:name)
  end
end
