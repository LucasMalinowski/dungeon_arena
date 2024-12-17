class TraitSpecificSpell < ApplicationRecord
  belongs_to :trait
  has_many :specific_spell_options, dependent: :destroy, class_name: 'TraitSpecificSpellOption'
end