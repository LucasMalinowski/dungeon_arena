class MonsterProficiency < ApplicationRecord
  belongs_to :monster
  belongs_to :proficiency
end
