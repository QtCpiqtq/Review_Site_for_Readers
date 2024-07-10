class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :favorite_books, dependent: :destroy
  has_many :books, through: :favorite_books
  has_many :reviews, dependent: :destroy
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def added_to_favorite?(book_id)
    self.favorite_books.pluck(:book_id).include?(book_id)
  end
    
end
