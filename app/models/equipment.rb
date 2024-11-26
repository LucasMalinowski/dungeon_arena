class Equipment < ApplicationRecord
  has_many :class_starting_equipment, dependent: :destroy
  has_many :klasses, through: :class_starting_equipment
end
