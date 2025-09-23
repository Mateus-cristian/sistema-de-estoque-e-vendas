# frozen_string_literal: true

require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing for guest" do
    get root_url
    assert_response :success
  end

  test "should redirect authenticated user from root to home" do
    @user = User.create!(email: "test@example.com", password: "password", name: "Test")
    post user_session_path, params: { user: { email: @user.email, password: "password" } }
    get root_url
    assert_response :success
  end
end
