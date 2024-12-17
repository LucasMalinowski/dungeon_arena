class EquipmentCategory < ApplicationRecord
  has_many :equipments, dependent: :destroy
  has_many :adventuring_gears, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :shields, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :weapons, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :tools, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :mounts, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :armor, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :magical_items, foreign_key: "equipment_categories_id", dependent: :destroy
  has_many :shields, foreign_key: "equipment_categories_id", dependent: :destroy
end
