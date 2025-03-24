class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true

  after_save_commit :broadcast_message

  private

    def broadcast_message
      ActionCable.server.broadcast("chat_#{chat_id}", { sender: user_id, message_id: id })
    end
end
