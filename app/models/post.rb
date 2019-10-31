class Post < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 500 }
end
