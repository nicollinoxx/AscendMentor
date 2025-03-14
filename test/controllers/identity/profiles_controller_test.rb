require "test_helper"

class Identity::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate(users(:one))
    @user = users(:one)
  end

  test "should get index" do
    get identity_profiles_path
    assert_response :success
  end

  test "should get show" do
    get identity_profile_path(@user.name)
    assert_response :success
  end
end
