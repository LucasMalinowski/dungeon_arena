class ClassSpellcasting < ApplicationRecord
  belongs_to :klass
  belongs_to :spellcasting_ability, class_name: "AbilityScore", foreign_key: "ability_score_id"
  has_many :spellcasting_infos, dependent: :destroy
end
