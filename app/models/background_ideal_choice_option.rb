class BackgroundIdealChoiceOption < ApplicationRecord
  belongs_to :background_ideal_choice
  has_many :background_ideal_option_alignment, dependent: :destroy
end
