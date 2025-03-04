class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true, uniqueness: true

  before_update :must_be_owner

  def must_be_owner
    throw(:abort) unless Current.user == self
  end
end
