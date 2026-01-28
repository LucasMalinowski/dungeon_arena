module Dnd
  module CharacterProgression
    extend ActiveSupport::Concern

    included do
      has_many :character_classes, -> { order(level: :asc) }, dependent: :destroy, inverse_of: :character
      has_many :klasses, -> { distinct }, through: :character_classes
      has_many :subclasses, -> { distinct }, through: :klasses
      has_many :class_features, -> { distinct }, through: :klasses, source: :features
      has_many :subclass_features, -> { distinct }, through: :subclasses, source: :features
      has_many :known_spells, -> { distinct }, through: :klasses, source: :spells
    end

    def total_level
      character_classes.sum(:level)
    end

    def primary_class
      character_classes.max_by(&:level)&.klass
    end

    def class_progressions
      character_classes
    end

    def subclasses_for(klass)
      subclasses.select { |subclass| subclass.klass_id == klass.id }
    end

    def known_features
      (class_features + subclass_features).uniq
    end
  end
end
