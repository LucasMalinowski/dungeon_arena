class Subclass < ApplicationRecord
  belongs_to :klass

  with_options dependent: :destroy do
    has_many :spell_subclasses
    has_many :subclass_spell_prerequisites
    has_many :features
    has_many :levels, -> { where.not(subclass_id: nil).order(:level) }, inverse_of: :subclass
  end

  has_many :spells, -> { distinct }, through: :spell_subclasses

  def available_features(level:)
    levels
      .up_to(level)
      .includes(:features)
      .flat_map(&:features)
      .uniq
  end
end
