class Public::RelationshipsController < ApplicationController
  def create
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_to mypage_path(user.id)
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    case params[:delete_sort]
    when "0"
      redirect_to mypage_path(user.id)
    when "1"
      redirect_to followings_path(current_user.id)
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).order(created_at: :desc)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).order(created_at: :desc)
  end
end
