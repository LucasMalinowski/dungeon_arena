class WeaponProperty < ApplicationRecord
  has_many :weapon_property_weapons, dependent: :destroy, class_name: "WeaponPropertyWeapons"
  has_many :weapons, through: :weapon_property_weapons
end
