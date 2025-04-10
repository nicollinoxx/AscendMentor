class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :chats, through: :participants
  has_many :messages, dependent: :destroy
  has_many :tags, dependent: :destroy

  has_one  :user_detail, dependent: :destroy
  has_one_attached :avatar

  accepts_nested_attributes_for :user_detail

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, :email_address, presence: true, uniqueness: true

  scope :search_by_name_or_tag, -> (name) {
    left_joins(:tags).where('users.name LIKE :name OR tags.name LIKE :name', name: "#{name}%")
    .distinct.order(:name)
  }
end
