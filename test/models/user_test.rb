require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should not save user without name" do
    user = User.new(name: nil, email_address: @user.email_address, password: @user.password, password_confirmation: @user.password)
    assert_not user.save, "Saved the user without a name"
  end

  test "should save user with name" do
    user = User.new(name: "uniqueness", email_address: "another@gmail.com", password: "password", password_confirmation: "password")
    assert user.save, "Failed to save the user with a name"
  end

  test "should not save user with duplicate name" do
    user1 = User.create(name: "John Doe", email_address: "john@example.com", password: "password", password_confirmation: "password")
    user2 = User.new(name: "John Doe", email_address: "another@example.com", password: "password", password_confirmation: "password")

    assert_not user2.save, "Saved the user with a duplicate name"
  end
end
