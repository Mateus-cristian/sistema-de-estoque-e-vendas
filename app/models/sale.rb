class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user, :product, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :enough_stock

  before_create :calculate_total, :decrement_stock

  private

  def enough_stock
    errors.add(:base, "Insufficient stock") if product && quantity.to_i > product.quantity
  end

  def calculate_total
    self.total = product.price * quantity
  end

  def decrement_stock
    product.update!(quantity: product.quantity - quantity)
  end
end
