# frozen_string_literal: true

require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "test@example.com", password: "password", name: "Test")
    post user_session_path, params: { user: { email: @user.email, password: "password" } }
  end

  test "should get home" do
    get root_url
    assert_response :success
  end
end
