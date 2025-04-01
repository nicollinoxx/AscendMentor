require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate(users(:one))
    @message = messages(:one)
    @chat = chats(:one)
  end

  test "should get index" do
    get chat_messages_url(@chat)
    assert_response :success
  end

  test "should create message" do
    assert_difference -> { Message.count } do
      post chat_messages_url(@chat),
           params: { message: { content: "New message" } }, as: :turbo_stream
    end

    assert_response :success
  end

  test "should get edit" do
    get edit_chat_message_url(@chat, @message)
    assert_response :success
  end

  test "should update message" do
    patch chat_message_url(@chat, @message), params: { message: { content: "Message updated" } }, as: :turbo_stream

    assert_response :success
    @message.reload
    assert_equal "Message updated", @message.content
  end

  test "should destroy message" do
    assert_difference -> { Message.count }, -1 do
      delete chat_message_url(@chat, @message), as: :turbo_stream
    end

    assert_response :success
  end
end
