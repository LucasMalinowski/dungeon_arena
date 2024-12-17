class BackgroundPersonalityTraitChoice < ApplicationRecord
  belongs_to :background
  has_many :background_personality_trait_choice_options, dependent: :destroy
end
