class ClassStartingEquipment < ApplicationRecord
  belongs_to :klass
  belongs_to :equipment
  belongs_to :equipment_category
end