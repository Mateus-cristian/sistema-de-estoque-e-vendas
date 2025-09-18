# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, price: 10.0, quantity: 5) }

  it "is valid with valid attributes" do
    sale = Sale.new(user: user, product: product, quantity: 2)
    expect(sale).to be_valid
  end

  it "is invalid without a user" do
    sale = Sale.new(product: product, quantity: 2)
    expect(sale).not_to be_valid
  end

  it "is invalid without a product" do
    sale = Sale.new(user: user, quantity: 2)
    expect(sale).not_to be_valid
  end

  it "is invalid without quantity" do
    sale = Sale.new(user: user, product: product)
    expect(sale).not_to be_valid
  end

  it "is invalid if quantity is greater than product stock" do
    sale = Sale.new(user: user, product: product, quantity: 10)
    expect(sale).not_to be_valid
  end

  it "calculates total correctly" do
    sale = Sale.new(user: user, product: product, quantity: 3)
    sale.valid? # triggers calculation
    expect(sale.total).to eq(30.0)
  end
end
