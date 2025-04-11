class AddChatKeyToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :participants, :chat_key, :string
  end
end
