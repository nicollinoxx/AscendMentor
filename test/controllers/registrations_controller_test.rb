require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "Should register" do
    get new_registration_url
    assert_difference("User.count") do
      post registrations_url, params: { user: { email_address: "another_email_address@example.com", password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to root_url
  end
end
