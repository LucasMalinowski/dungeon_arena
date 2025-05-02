class SavingThrow < ApplicationRecord
  belongs_to :ability_score
  has_many :class_saving_throws, dependent: :destroy
  has_many :klasses, through: :class_saving_throws

  def name
    ability_score.name
  end
end
