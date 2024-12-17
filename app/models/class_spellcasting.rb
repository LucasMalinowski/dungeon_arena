class ClassSpellcasting < ApplicationRecord
  belongs_to :klass
  belongs_to :ability_score
  has_many :spellcasting_infos
end
