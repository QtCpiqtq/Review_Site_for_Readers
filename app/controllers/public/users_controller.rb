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
      flash[:notice] = '編集内容を保存しました。'
      redirect_to information_path
    else
      flash.now[:alert] = '編集の保存に失敗しました。'
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
    if user.update(is_active: false)
      sign_out user
      flash[:notice] = '退会が完了しました。ご利用ありがとうございました。'
      redirect_to root_path
    else
      flash.now[:alert] = '退会に失敗しました。時間をおいてから再度お試しください。'
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :image, :is_active)
  end
end
