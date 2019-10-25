class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 20 }
  
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  
end
