class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :evolution, presence: true
  validates :body, presence: true

  enum evolution: {
  ★☆☆☆☆: 1,
  ★★☆☆☆: 2,
  ★★★☆☆: 3,
  ★★★★☆: 4,
  ★★★★★: 5
  }

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

  def get_book_date(isbn)
    RakutenWebService::Books::Book.search(isbn: isbn).first
  end
end
