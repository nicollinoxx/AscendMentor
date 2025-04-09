class Tag < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validate :maximum_length, on: :create

  private

    def maximum_length
      errors.add(:base, "You can only have up to 15 tags.") if user.tags.size >= 14
    end
end
