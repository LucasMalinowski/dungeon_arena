class Trait < ApplicationRecord
  has_many :subrace_traits
  has_many :subraces, through: :subrace_traits
  has_many :race_traits
  has_many :races, through: :race_traits
  has_many :proficiency_traits
  has_many :proficiencies, through: :proficiency_traits
end
