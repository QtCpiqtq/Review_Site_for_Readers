class Book < ApplicationRecord
    has_many :favorite_books
    has_many :reviews, dependent: :destroy
    has_many :wish_lists, dependent: :destroy
    

	def get_book_date(isbn)
	  book = RakutenWebService::Books::Book.search(isbn: isbn).first
	  book.present? ? book : nil
	end
	
	def get_book_title(isbn)
	  book = RakutenWebService::Books::Book.search(isbn: isbn).first
	  if book.present?
	  	book.title
	  else 
	  	"本が見つかりません"
	  end
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
