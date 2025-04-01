class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for Chat.find(params[:id])
  end
end
