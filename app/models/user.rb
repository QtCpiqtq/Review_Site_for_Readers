class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true
  
  has_one_attached :image
  has_many :favorite_books, dependent: :destroy
  has_many :books, through: :favorite_books
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :wish_lists, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def added_to_favorites?(book_id)
    self.favorite_books.pluck(:book_id).include?(book_id)
  end
  
  def added_to_wish_lists?(book_id)
    self.wish_lists.pluck(:book_id).include?(book_id)
  end
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
   enum is_active: {
    "有効": true,
    "無効": false
   }
end
