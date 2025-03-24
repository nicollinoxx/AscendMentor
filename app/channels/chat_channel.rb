class ChatChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:id]
    stream_from "chat_#{params[:id]}"
  end
end
