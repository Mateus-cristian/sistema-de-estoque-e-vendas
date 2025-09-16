# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin Dashboard", type: :request do
  let(:admin) { FactoryBot.create(:user, role: "admin", password: "password") }
  let(:user) { FactoryBot.create(:user, role: "user", password: "password") }

  context "admin user" do
    it "can access the dashboard" do
      sign_in admin
      get admin_dashboard_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Admin Dashboard")
    end
  end

  context "normal user" do
    it "is redirected with access denied" do
      sign_in user
      get admin_dashboard_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Access denied")
    end
  end

  context "guest" do
    it "is redirected to login page" do
      get admin_dashboard_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
