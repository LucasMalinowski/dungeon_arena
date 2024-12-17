class Subclass < ApplicationRecord
  belongs_to :klass
  has_many :spell_subclasses, dependent: :destroy
  has_many :spells, through: :spell_subclasses
  has_many :subclass_spell_prerequisites, dependent: :destroy
  has_many :features, dependent: :destroy
end
