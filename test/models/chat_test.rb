require "test_helper"

class ChatTest < ActiveSupport::TestCase
  test "should save chat" do
    message = Chat.new
    assert message.save, "Saved the message without content"
  end
end
