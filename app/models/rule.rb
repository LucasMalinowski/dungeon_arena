class Rule < ApplicationRecord
  belongs_to :rule_scope, optional: true
end
