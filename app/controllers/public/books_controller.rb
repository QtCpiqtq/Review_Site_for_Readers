class Public::BooksController < ApplicationController
  def search
  end
  
  def index
    if params[:keyword].present?
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    else
    redirect_to books_search_path
    end
  end

  def show
    @book_id = Book.find_by(isbn: params[:isbn])&.id
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @favorite_book = FavoriteBook.new
  end
  
  private
  def book_params
    params.require(:book).permit(:isbn)
  end
end
