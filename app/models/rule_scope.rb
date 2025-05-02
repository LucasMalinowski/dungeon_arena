class RuleScope < ApplicationRecord
  has_many :rules, dependent: :destroy
end
