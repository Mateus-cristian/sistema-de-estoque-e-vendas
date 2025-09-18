# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = FactoryBot.build(:product)
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product = FactoryBot.build(:product, name: nil)
    expect(product).not_to be_valid
  end

  it "is invalid with a price <= 0" do
    product = FactoryBot.build(:product, price: 0)
    expect(product).not_to be_valid
  end

  it "is invalid with quantity < 0" do
    product = FactoryBot.build(:product, quantity: -1)
    expect(product).not_to be_valid
  end
end
