class BackgroundBondChoice < ApplicationRecord
  belongs_to :background
  has_many :background_bond_choice_options, dependent: :destroy
end
