class SubraceLanguageChoice < ApplicationRecord
  belongs_to :subrace
  has_many :subrace_language_choice_options
end
