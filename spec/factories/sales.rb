# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    product { nil }
    user { nil }
    quantity { 1 }
    total { "9.99" }
  end
end
