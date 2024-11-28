class DamageType < ApplicationRecord
  has_many :weapon_damage_types, dependent: :destroy, class_name: "WeaponDamageTypes"
  has_many :weapons, through: :weapon_damage_types
end
