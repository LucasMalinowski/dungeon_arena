class Level < ApplicationRecord
  belongs_to :klass
  belongs_to :subclass, optional: true

  has_many :level_features, dependent: :destroy
  has_many :features, through: :level_features

  has_many :level_specifics, dependent: :destroy

  has_one :level_spellcasting, dependent: :destroy

  delegate :spell_slots_level_1, :spell_slots_level_2, :spell_slots_level_3,
           :spell_slots_level_4, :spell_slots_level_5, :spell_slots_level_6,
           :spell_slots_level_7, :spell_slots_level_8, :spell_slots_level_9,
           :spells_known, :cantrips_known, to: :level_spellcasting, allow_nil: true

  scope :up_to, ->(level_number) { where(arel_table[:level].lteq(level_number)) }

  def inherited_features
    klass.levels
         .up_to(level)
         .includes(:features)
         .flat_map(&:features)
         .uniq
  end

  def inherited_level_specifics
    klass.levels
         .up_to(level)
         .includes(:level_specifics)
         .flat_map(&:level_specifics)
         .uniq
  end
end
