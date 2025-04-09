require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @chat = chats(:one)
    @user = users(:one)
  end

  test "should not save message without content" do
    message = Message.new(chat: @chat, user: @user)
    assert_not message.save
  end

  test "should save message with content" do
    message = Message.new(content: "Valid content", chat: @chat, user: @user)
    assert message.save
  end
end
