require "rails_helper"

RSpec.describe "Navbar", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:admin) { FactoryBot.create(:user, role: :admin, password: "password") }
  let(:user) { FactoryBot.create(:user, role: :user, password: "password") }

  context "as guest" do
    it "shows login and sign up links" do
      visit root_path
      expect(page).to have_link("Log in", href: new_user_session_path)
      expect(page).to have_link("Sign up", href: new_user_registration_path)
      expect(page).not_to have_link("Admin Dashboard")
      expect(page).not_to have_link("Logout")
    end
  end

  context "as normal user" do
    it "shows home and logout links" do
      login_as(user, scope: :user)
      visit root_path
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("Logout", href: destroy_user_session_path)
      expect(page).not_to have_link("Admin Dashboard")
    end
  end

  context "as admin user" do
    it "shows admin dashboard and logout links" do
      login_as(admin, scope: :user)
      visit root_path
      expect(page).to have_link("Admin Dashboard", href: admin_dashboard_path)
      expect(page).to have_link("Logout", href: destroy_user_session_path)
    end
  end
end
