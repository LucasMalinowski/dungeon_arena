class Feat < ApplicationRecord
  belongs_to :ability_score, optional: true
end
