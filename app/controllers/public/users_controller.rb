class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:guest_login, :index]
  
  def mypage
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).order(created_at: :desc)
    @wish_lists = @user.wish_lists.all
    @favorite_books = @user.books.all
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
    if user.update(is_active: "無効")
      user.update(name: user.name + "(退会済みユーザー)")
      sign_out user
      flash[:notice] = '退会が完了しました。ご利用ありがとうございました。'
      redirect_to root_path
    else
      flash.now[:alert] = '退会に失敗しました。時間をおいてから再度お試しください。'
      render :edit
    end
  end

  def guest_login
    @user = User.find_or_initialize_by(name: "ゲスト", email: 'guest@guest')
    @user.password = SecureRandom.hex(10)
    @user.save
    flash[:notice] = "ログインに成功しました。"
    sign_in(@user)
    redirect_to mypage_path(current_user.id)
  end
  
  def index
    if params[:keyword].present?
      active_users = User.where(is_active: "有効")
      @users = active_users.where("name LIKE ?", "%#{params[:keyword]}%").page(params[:page])
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image, :is_active)
  end
end
