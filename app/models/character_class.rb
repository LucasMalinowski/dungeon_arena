class CharacterClass < ApplicationRecord
  belongs_to :character
  belongs_to :klass

  validates :level, numericality: { greater_than_or_equal_to: 1 }

  delegate :name, :hit_die, to: :klass, prefix: true

  def available_features
    base_features = klass.available_features(level: level)
    subclass_features = subclass_choices.flat_map { |subclass| subclass.available_features(level: level) }
    (base_features + subclass_features).uniq
  end

  def subclass_choices
    character.subclasses_for(klass)
  end
end
