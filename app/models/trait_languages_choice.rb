class TraitLanguagesChoice < ApplicationRecord
  belongs_to :trait
  has_many :trait_languages_choice_options, dependent: :destroy
end