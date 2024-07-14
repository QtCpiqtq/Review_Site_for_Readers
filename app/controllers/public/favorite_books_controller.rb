class Public::FavoriteBooksController < ApplicationController
  def create
    book = Book.find_or_create_by(isbn: params[:isbn])
    current_user.favorite_books.find_or_create_by(book_id: book.id)
    redirect_to book_path(book.isbn)
  end

  def destroy
    book = Book.find(params[:id])
    current_user.favorite_books.find_by(book_id: book.id)&.destroy
    case params[:delete_sort]
    when "0"
      redirect_to information_path
    when "1"
      redirect_to book_path(book.isbn)
    end
  end

  private
  def favorite_book_params
    params.require(:favorite_book).permit(:user_id, :book_id)

  end
end
