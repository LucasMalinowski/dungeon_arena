# frozen_string_literal: true

class CharacterInventory < ApplicationRecord
  belongs_to :character
  has_many :inventory_items, dependent: :destroy

  validates :copper, :silver, :electrum, :gold, :platinum, presence: true
  validates :copper, :silver, :electrum, :gold, :platinum, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def total_currency_in_gold
    copper / 100 + silver / 10 + electrum / 2 + gold + platinum * 10
  end
end
