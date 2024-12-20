class Klass < ApplicationRecord
  has_many :class_proficiencies, dependent: :destroy
  has_many :proficiencies, through: :class_proficiencies

  has_many :proficiency_choices
  has_many :proficiency_options, through: :proficiency_choices, source: :proficiency_choice_options

  has_many :subclasses, dependent: :destroy
  has_many :features, dependent: :destroy

  has_many :spell_classes, dependent: :destroy
  has_many :spells, through: :spell_classes

  has_many :multiclassings, dependent: :destroy
  has_many :multiclassing_prerequisites, through: :multiclassings
  has_many :multiclassing_proficiencies, through: :multiclassings
  has_many :multiclassing_proficiency_choices, through: :multiclassings

  has_many :class_saving_throws, dependent: :destroy
  has_many :saving_throws, through: :class_saving_throws

  has_many :starting_equipment, dependent: :destroy, class_name: "ClassStartingEquipment"

  has_many :class_starting_equipment_choices, dependent: :destroy
  has_many :starting_equipment_options, through: :class_starting_equipment_choices, source: :class_starting_equipment_choice_options

  has_one :class_spellcasting, dependent: :destroy
  has_one :spellcasting_ability, through: :class_spellcasting
  has_many :spellcasting_infos, through: :class_spellcasting

  has_many :levels, dependent: :destroy
  has_many :level_features, through: :levels
  has_many :level_specifics, through: :levels
  has_many :level_spellcasting, through: :levels

  def available_features(level:)
    levels.find_by(level: level).inherited_features
  end
end
