# frozen_string_literal: true

class InventoryItem < ApplicationRecord
  belongs_to :character_inventory
  belongs_to :equipment

  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
