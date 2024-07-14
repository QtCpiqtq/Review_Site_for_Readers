class Book < ApplicationRecord
    has_many :favorite_books
    has_many :reviews, dependent: :destroy
    has_many :wish_lists, dependent: :destroy
    
	def get_book_date(isbn)
		RakutenWebService::Books::Book.search(isbn: isbn).first
	end
	
	def self.get_reviews(isbn)
    book = Book.find_by(isbn: isbn)
    if book
      book.reviews
    else
      []
    end
	end
end
