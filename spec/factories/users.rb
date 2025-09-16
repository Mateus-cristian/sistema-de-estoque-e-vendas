# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    role { "user" }
    password { "password" }
    password_confirmation { "password" }
  end
end
