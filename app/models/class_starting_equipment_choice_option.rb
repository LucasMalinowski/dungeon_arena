class ClassStartingEquipmentChoiceOption < ApplicationRecord
  belongs_to :class_starting_equipment_choice
  belongs_to :equipment, optional: true
  belongs_to :equipment_category, optional: true
  has_many :equipments, through: :equipment_category
end
