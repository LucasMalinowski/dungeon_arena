class Armor < ApplicationRecord
  has_one :equipment, as: :equipmentable, dependent: :destroy
  belongs_to :equipment_category, foreign_key: "equipment_categories_id"
end
