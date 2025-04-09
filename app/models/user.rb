class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :chats, through: :participants
  has_many :tags, dependent: :destroy

  has_one  :user_detail, dependent: :destroy
  has_one_attached :avatar

  accepts_nested_attributes_for :user_detail

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, :email_address, presence: true, uniqueness: true
end
