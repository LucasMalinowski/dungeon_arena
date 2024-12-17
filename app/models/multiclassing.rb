class Multiclassing < ApplicationRecord
  belongs_to :klass
  has_many :multiclassing_proficiencies
  has_many :proficiencies, through: :multiclassing_proficiencies
  has_many :multiclassing_prerequisites
  has_many :multiclassing_proficiency_choices
  has_many :proficiency_choices, through: :multiclassing_proficiency_choices
end
