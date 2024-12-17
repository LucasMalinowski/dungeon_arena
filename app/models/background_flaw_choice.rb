class BackgroundFlawChoice < ApplicationRecord
  belongs_to :background
  has_many :background_flaw_choice_options, dependent: :destroy
end
