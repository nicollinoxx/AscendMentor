class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for Chat.find(params[:chat_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
