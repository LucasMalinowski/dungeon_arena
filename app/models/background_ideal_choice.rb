class BackgroundIdealChoice < ApplicationRecord
  belongs_to :background
  has_many :background_ideal_choice_options, dependent: :destroy
end
