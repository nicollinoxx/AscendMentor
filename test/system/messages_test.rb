require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    authenticate(users(:one))
    @message = messages(:one)
    @chat    = chats(:one)
  end

  test "visiting the index" do
    visit chat_messages_url(@chat)
    assert_selector "h1", text: "Messages"
  end

  test "should create message" do
    visit chat_messages_url(@chat)

    find("textarea").set(@message.content)
    find("button svg").click
  end

  test "should update Message" do
    visit chat_messages_url(@chat)
    click_on "Edit", match: :first

    find("textarea").set(@message.content)
    find("button svg").click
  end

  test "should destroy Message" do
    visit chat_messages_url(@chat)
    click_on "Edit", match: :first
    click_on "Destroy"
    accept_alert "Are you sure?"

    assert_text "Message was successfully destroyed."
  end
end
