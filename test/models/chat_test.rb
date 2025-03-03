require "test_helper"

class ChatTest < ActiveSupport::TestCase
  test "should not save chat without content" do
    message = Chat.new
    assert_not message.save, "Saved the message without content"
  end

  test "should save chat with content" do
    message = Chat.new(title: "Valid content")
    assert message.save, "Failed to save the message with content"
  end
end
