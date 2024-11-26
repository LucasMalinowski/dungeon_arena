class Klass < ApplicationRecord
  has_many :class_proficiencies, dependent: :destroy
  has_many :proficiencies, through: :class_proficiencies
  has_many :class_saving_throws, dependent: :destroy
  has_many :saving_throws, through: :class_saving_throws
  has_many :class_starting_equipment, dependent: :destroy
  has_many :starting_equipment, through: :class_starting_equipment, source: :equipment
end
