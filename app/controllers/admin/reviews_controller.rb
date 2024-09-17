class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:search_reviews_id].present?
      @user = User.find(params[:search_reviews_id])
      @reviews = @user.reviews.page(params[:page]).order(created_at: :desc)
    else
      @reviews = Review.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @review = Review.find(params[:id])
    @comments = @review.comments.page(params[:page]).order(created_at: :desc)
  end
  
  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:notice] = "レビューを削除しました。"
      redirect_to admin_reviews_path
    else
      flash.now[:alert] = "レビュー削除に失敗しました"
      render :show
    end
  end
end
