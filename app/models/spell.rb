class Spell < ApplicationRecord
  has_many :spell_classes
  has_many :klasses, through: :spell_classes

  has_many :spell_subclasses
  has_many :subclasses, through: :spell_subclasses

  belongs_to :magic_school, optional: true
  belongs_to :damage_type, optional: true
end
