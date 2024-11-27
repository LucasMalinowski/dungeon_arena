class Skill < ApplicationRecord
  belongs_to :ability_score, foreign_key: 'ability_score_id'
end
