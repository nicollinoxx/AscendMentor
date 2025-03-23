class RemoveTitleFromChat < ActiveRecord::Migration[6.0]
  def change
    remove_column :chats, :title, :string
  end
end
