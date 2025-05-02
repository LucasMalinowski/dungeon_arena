class Multiclassing < ApplicationRecord
  belongs_to :klass

  has_many :multiclassing_proficiencies, dependent: :destroy
  has_many :proficiencies, through: :multiclassing_proficiencies

  has_many :multiclassing_prerequisites, dependent: :destroy

  has_many :multiclassing_proficiency_choices, dependent: :destroy
  has_many :proficiency_choices, through: :multiclassing_proficiency_choices
end
