class RaceLanguageChoice < ApplicationRecord
  belongs_to :race
  has_many :race_language_choice_options
end
