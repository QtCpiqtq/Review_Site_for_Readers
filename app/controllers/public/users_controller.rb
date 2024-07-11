class Public::UsersController < ApplicationController
  def mypage
    @user = User.find(params[:id])
    @reviews = @user.reviews.all
    @favorite_books = @user.books
  end

  def information
    @user = current_user
    @favorite_books = @user.favorite_books
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to information_path
    else
      render :edit
    end
  end
  
  def destroy
    image = current_user.image
    image.destroy
    redirect_to information_edit_path
  end

  def unsubscribe
  end
  
  def withdraw
    user = current_user
    user.update(is_active: false)
    sign_out user
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :image, :is_active)
  end
end
