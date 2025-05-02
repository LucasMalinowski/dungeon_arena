class Weapon < ApplicationRecord
  has_one :equipment, as: :equipmentable
  belongs_to :equipment_category, foreign_key: "equipment_categories_id"

  has_many :weapon_properties_weapons, dependent: :destroy, class_name: "WeaponPropertyWeapons"
  has_many :weapon_properties, through: :weapon_properties_weapons

  has_many :weapon_damage_types, dependent: :destroy, class_name: "WeaponDamageTypes"
  has_many :damage_types, through: :weapon_damage_types
end
