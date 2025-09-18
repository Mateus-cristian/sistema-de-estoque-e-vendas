# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1..100.0) }
    quantity { Faker::Number.between(from: 0, to: 50) }
  end
end
