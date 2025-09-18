# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user, :product, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :enough_stock

  before_validation :calculate_total

  private

  def enough_stock
      if product && quantity.present? && quantity > product.quantity
        errors.add(:quantity, "exceeds available stock")
      end
  end

  def calculate_total
    self.total = product.price * quantity if product && quantity
  end
end
