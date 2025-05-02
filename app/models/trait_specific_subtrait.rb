class TraitSpecificSubtrait < ApplicationRecord
  belongs_to :trait
  has_many :trait_specific_subtrait_options, dependent: :destroy
end