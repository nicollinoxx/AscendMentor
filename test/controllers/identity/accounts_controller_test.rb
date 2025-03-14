require "test_helper"

class Identity::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate(users(:one))
    @user = users(:one)
  end

  test "should get show" do
    get identity_account_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_identity_account_path(@user)
    assert_response :success
  end

  test "should update account" do
    patch identity_account_path(@user), params: { user: { name: @user.name } }
    assert_redirected_to identity_account_path(@user)
  end
end
