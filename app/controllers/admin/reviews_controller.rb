class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    if params[:search_reviews_id].present?
      user = User.find(params[:search_reviews_id])
      @reviews = user.reviews.all.order(created_at: :desc)
    else
      @reviews = Review.all.order(created_at: :desc)
    end
  end

  def show
    @review = Review.find(params[:id])
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました"
    redirect_to admin_reviews_path
  end
end
