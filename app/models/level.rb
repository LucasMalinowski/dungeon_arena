class Level < ApplicationRecord
  belongs_to :klass
  belongs_to :subclass, optional: true

  has_many :level_features, dependent: :destroy
  has_many :features, through: :level_features

  has_many :level_specifics, dependent: :destroy

  has_one :level_spellcasting, dependent: :destroy

  delegate :spell_slots_level_1, :spell_slots_level_2, :spell_slots_level_3, :spell_slots_level_4, :spell_slots_level_5, :spell_slots_level_6, :spell_slots_level_7, :spell_slots_level_8, :spell_slots_level_9, :spells_known, :cantrips_known, to: :level_spellcasting, allow_nil: true

  def inherited_features
    klass.levels
         .where("level <= ?", level)
         .includes(:features)
         .flat_map(&:features)
         .uniq
  end

  def inherited_level_specifics
    klass.levels
         .where("level <= ?", level)
         .includes(:level_specifics)
         .flat_map(&:level_specifics)
         .uniq
  end

end
