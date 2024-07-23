class WishList < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  def get_book_date(isbn)
    RakutenWebService::Books::Book.search(isbn: isbn).first
  end
end
