class TraitSpecificSubtraitOption < ApplicationRecord
  belongs_to :trait_specific_subtrait
  belongs_to :subtrait, class_name: 'Trait', foreign_key: 'trait_id'
end