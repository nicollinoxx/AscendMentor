require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate(users(:one))
    @chat = chats(:one)
    @host = users(:one)
    @guest = users(:two)
  end

  test "should get index" do
    get chats_url
    assert_response :success
  end

  test "should create chat and participants" do
    assert_difference("Chat.count", 1) do
      assert_difference("Participant.count", 2) do
        post create_chat_path(guest: @guest.name)
      end
    end

    assert_redirected_to chat_messages_url(Chat.last)
  end

  test "should destroy chat" do
    assert_difference("Chat.count", -1) do
      delete chat_url(@chat)
    end

    assert_redirected_to chats_url
  end
end
