require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @chat = chats(:one)
  end

  test "should not save message without content" do
    message = Message.new(chat_id: @chat.id)
    assert_not message.save
  end

  test "should save message with content" do
    message = Message.new(content: "Valid content", chat_id: @chat.id)
    assert message.save
  end
end
