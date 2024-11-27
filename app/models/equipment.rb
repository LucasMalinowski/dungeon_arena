class Equipment < ApplicationRecord
  belongs_to :equipmentable, polymorphic: true
end