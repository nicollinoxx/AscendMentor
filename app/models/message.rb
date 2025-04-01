class Message < ApplicationRecord
  belongs_to :chat

  validates :content, presence: true

  after_save_commit :broadcast_message

  broadcasts_to :chat, target: "messages", locals: { chat: @chat }, action: :append

  private

    def broadcast_message
      ActionCable.server.broadcast("chat_#{chat_id}", { sender: user_id, message_id: id })
    end
end
