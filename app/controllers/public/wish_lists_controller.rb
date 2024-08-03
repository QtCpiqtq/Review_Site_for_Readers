class Public::WishListsController < ApplicationController
  def create
    book = Book.find_or_create_by(isbn: params[:isbn])
    current_user.wish_lists.find_or_create_by(book_id: book.id)
    redirect_to book_path(book.isbn)
  end

  def destroy
    book = Book.find(params[:id])
    current_user.wish_lists.find_by(book_id: book.id)&.destroy
    case params[:delete_sort]
    when "0"
      redirect_to wish_lists_index_path(current_user.id)
    when "1"
      redirect_to book_path(book.isbn)
    end
  end

  def index
    @user = User.find(params[:id])
    @wish_lists = @user.wish_lists.all.order(created_at: :desc)
  end

  private
  def wish_lists_params
    params.require(:wish_ists).permit(:user_id, :book_id)

  end
end
