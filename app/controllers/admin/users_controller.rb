class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.is_active == "有効"
      user.update(is_active: "無効")
      user.update(name: user.name + "(退会済みユーザー)")
    elsif user.is_active == "無効"
      user.update(is_active: "有効")
      user_name = user.name.gsub("(退会済みユーザー)", "").strip
      user.update(name: user_name)
    end
    redirect_to admin_user_path(user.id)
  end
end
