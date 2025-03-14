require "test_helper"

class Identity::AvatarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate(users(:one))
    @user = users(:one)
    @file = fixture_file_upload(Rails.root.join("test/fixtures/files/avatars/avatar.jpeg"), "image/jpeg")
  end

  test "should get edit" do
    get edit_identity_avatar_path(@user)
    assert_response :success
  end

  test "should update avatar" do
    patch identity_avatar_path(@user), params: { avatar: @file }

    assert_redirected_to identity_account_url(@user)
    assert @user.reload.avatar.attached?
  end

  test "should destroy avatar" do
    delete identity_avatar_path(@user)
    assert_not @user.reload.avatar.attached?

    assert_redirected_to identity_account_path(@user)
  end
end
