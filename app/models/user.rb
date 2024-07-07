class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :faborite_books, dependent: :destroy
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
    
end
