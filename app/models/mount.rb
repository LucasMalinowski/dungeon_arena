class Mount < ApplicationRecord
  has_one :equipment, as: :equipmentable
  belongs_to :equipment_category, foreign_key: "equipment_categories_id"

end
