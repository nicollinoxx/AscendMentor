class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ destroy ]
  before_action :set_participants, only: %i[ create ]

  def index
    @chats = Current.user.chats
  end

  def create
    @chat = Chat.new
    chat_key = [@host.id, @guest.id].sort.join('-')
    @chat.participants.build(user_id: @host.id, chat_key: chat_key)
    @chat.participants.build(user_id: @guest.id, chat_key: chat_key)

    if @chat.save
      redirect_to chat_messages_path(@chat)
      ChatsMailer.notify(@chat, @host, @guest).deliver_later
    else
      redirect_to identity_profile_path(@guest.name), alert: "#{@chat.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @chat.destroy!
    redirect_to chats_path, notice: "Chat was successfully destroyed.", status: :see_other
  end

  private

    def set_chat
      @chat = Chat.find(params.expect(:id))
    end

    def set_participants
      @host = Current.user
      @guest = User.find_by!(name: params[:guest])
    end
end
