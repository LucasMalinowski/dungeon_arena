class ClassStartingEquipment < ApplicationRecord
  belongs_to :klass, class_name: 'Klass'
  belongs_to :equipment
end
