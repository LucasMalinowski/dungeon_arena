class Feature < ApplicationRecord
  belongs_to :subclass, optional: true
  belongs_to :klass, optional: true
  belongs_to :parent, class_name: 'Feature', optional: true, foreign_key: 'parent_id'

  with_options dependent: :destroy do
    has_many :feature_prerequisites
    has_many :subfeature_options
    has_many :expertise_options
    has_many :invocations
    has_many :level_features
  end

  has_many :levels, through: :level_features
  has_many :children, class_name: 'Feature', foreign_key: :parent_id, inverse_of: :parent, dependent: :nullify

  scope :class_features, -> { where.not(klass_id: nil) }
  scope :subclass_features, -> { where.not(subclass_id: nil) }

  def source
    subclass || klass
  end

  def source_name
    source&.name
  end
end
