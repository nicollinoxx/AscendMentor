class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true

  after_save_commit :broadcast_message

  private

    def broadcast_message
      ChatChannel.broadcast_to(chat, { sender: user.name, message_id: id })
    end
end
