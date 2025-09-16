# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "Sign up" do
    it "creates a new user" do
      expect {
        post user_registration_path, params: {
          user: {
            name: "John",
            email: "john@example.com",
            password: "password",
            password_confirmation: "password",
            role: "user"
          }
        }
      }.to change(User, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /users/sign_in" do
    it "responds 200 OK" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_out" do
    it "logs out the user" do
      sign_in user
      expect {
        delete destroy_user_session_path
      }.to change(User, :count).by(0)
      expect(response).to redirect_to(root_path)
    end
  end
end
