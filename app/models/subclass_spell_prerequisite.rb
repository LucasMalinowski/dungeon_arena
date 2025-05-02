class SubclassSpellPrerequisite < ApplicationRecord
  belongs_to :subclass
  belongs_to :spell
end
