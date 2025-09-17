# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name, email, and role" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to be_invalid
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to be_invalid
  end

  it "is invalid without a role" do
    user = FactoryBot.build(:user, role: nil)
    expect(user).to be_invalid
  end

  it "is invalid with an invalid role" do
    user = FactoryBot.build(:user, role: nil)
    expect(user).to be_invalid
  end

  it "is invalid with a duplicate email" do
    FactoryBot.create(:user, email: "test@example.com")
    user = FactoryBot.build(:user, email: "test@example.com")
    expect(user).to be_invalid
  end

  it "is invalid with a short password" do
    user = FactoryBot.build(:user, password: "123", password_confirmation: "123")
    expect(user).not_to be_valid
  end

  it "is invalid when password and password_confirmation do match" do
    user = FactoryBot.build(:user, password: "password", password_confirmation: "password")
    expect(user).to be_valid
  end

  it "is invalid when password and password_confirmation do not match" do
    user = FactoryBot.build(:user, password: "password", password_confirmation: "different")
    expect(user).not_to be_valid
  end
end
