class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  validates_associated :participants

  validate :chat_key_must_be_unique, on: :create

  private

    def chat_key_must_be_unique
      chat_keys = participants.map(&:chat_key)

      if Participant.exists?(chat_key: chat_keys)
        errors.add(:base, "Chat already exists")
      end
    end
end
