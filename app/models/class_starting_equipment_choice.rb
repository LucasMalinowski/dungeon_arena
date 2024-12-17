class ClassStartingEquipmentChoice < ApplicationRecord
  belongs_to :klass
  has_many :class_starting_equipment_choice_options, dependent: :destroy
end
