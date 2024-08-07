class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  
  validates :evolution, presence: true
  validates :body, presence: true


  enum feeling_after_reading: {
    "感動的": 0,
    "楽しい": 1,
    "悲しい": 2,
    "ワクワク": 3,
    "怖い": 4,
    "ときめく": 5,
    "爽快": 6,
    "モヤモヤする": 7,
    "笑える": 8,
    "実用的": 9,
    "学びがある": 10,
    "心動かす": 11,
    "その他": 12,
  }

  def good_by?(user)
    goods.exists?(user_id: user.id)
  end
end
