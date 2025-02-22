require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    @message = messages(:one)
    @chat    = chats(:one)
  end

  test "visiting the index" do
    visit chat_messages_url(@chat)
    assert_selector "h1", text: "Messages"
  end

  test "should create message" do
    visit chat_messages_url(@chat)

    fill_in "Content", with: @message.content
    click_on "Create Message"
  end

  test "should update Message" do
    visit chat_messages_url(@chat)
    click_on "Edit", match: :first

    fill_in "Content", with: @message.content
    click_on "Update Message"

    assert_text "Message was successfully updated."
  end

  test "should destroy Message" do
    visit chat_messages_url(@chat)
    click_on "Destroy", match: :first
    accept_alert "Are you sure?"

    assert_text "Message was successfully destroyed."
  end
end
