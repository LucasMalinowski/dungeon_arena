class TraitSpecificSpellOption < ApplicationRecord
  belongs_to :trait_specific_spell
  belongs_to :spell
end