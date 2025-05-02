class Feature < ApplicationRecord
  belongs_to :subclass, optional: true
  belongs_to :klass, optional: true
  belongs_to :parent, class_name: 'Feature', optional: true, foreign_key: 'parent_id'

  has_many :feature_prerequisites, dependent: :destroy
  has_many :subfeature_options, dependent: :destroy

  has_many :expertise_options, dependent: :destroy

  has_many :invocations, dependent: :destroy

  has_many :level_features, dependent: :destroy
  has_many :levels, through: :level_features
end
