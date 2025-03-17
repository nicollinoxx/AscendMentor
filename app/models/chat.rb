class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  validates :title, presence: true

  after_save :must_have_saved_two_or_more_participants

  def must_have_saved_two_or_more_participants
    if participants.count < 2
      self.destroy
    end
  end
end
