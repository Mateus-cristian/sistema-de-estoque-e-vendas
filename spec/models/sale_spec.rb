# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale, type: :model do
  let(:user)    { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, quantity: 10, price: 100) }

  it "is valid with sufficient stock" do
    sale = Sale.new(user: user, product: product, quantity: 2)
    expect(sale).to be_valid
  end

  it "is invalid with insufficient stock" do
    sale = Sale.new(user: user, product: product, quantity: 20)
    expect(sale).not_to be_valid
    expect(sale.errors[:base]).to include("Estoque insuficiente")
  end

  it "calculates total correctly" do
    sale = Sale.create!(user: user, product: product, quantity: 3)
    expect(sale.total).to eq(300)
  end

  it "decrements product quantity after create" do
    expect {
      Sale.create!(user: user, product: product, quantity: 4)
    }.to change { product.reload.quantity }.by(-4)
  end
end
