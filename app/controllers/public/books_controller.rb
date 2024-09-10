class Public::BooksController < ApplicationController
  before_action :authenticate_user!, except: [:search, :index, :show]

  def search
  end

  def index
    if params[:keyword].present?
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    elsif params[:feeling_after_reading].present?
      @books = []
      reviews = Review.where(feeling_after_reading: params[:feeling_after_reading])
      reviews.each do |review|
        unless @books.any? {|book| book.isbn == review.book.isbn}
          if RakutenWebService::Books::Book.search(isbn: review.book.isbn).first.present?
            result = RakutenWebService::Books::Book.search(isbn: review.book.isbn).first
            @books << result
          end
        end
      end
    else
      redirect_to books_search_path
    end
  end

  def show
    @book_id = Book.find_by(isbn: params[:isbn])&.id
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @favorite_book = FavoriteBook.new
    @reviews = Book.get_reviews(@book.isbn)
    if @reviews.present?
      @reviews_sorted = @reviews.page(params[:page]).order(created_at: :desc)
    end
  end

  private
  def book_params
    params.require(:book).permit(:isbn)
  end
end
