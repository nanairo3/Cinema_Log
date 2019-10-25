class Post < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  validates :content, presence: true, length: { maximum: 500 }
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
