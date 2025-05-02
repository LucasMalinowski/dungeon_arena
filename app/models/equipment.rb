class Equipment < ApplicationRecord
  belongs_to :equipmentable, polymorphic: true
  belongs_to :equipment_category, optional: true, foreign_key: 'equipment_category_id'

  def equipment_category
    equipmentable.equipment_category
  end
end