class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @review = Review.find(params[:review_id])
    comment = current_user.comments.new(comment_params)
    comment.review_id = @review.id
    if comment.save
      flash[:notice] = "コメント投稿に成功しました。"
      redirect_to review_path(comment.review_id)
    else
      flash.now[:alert] = "コメント投稿に失敗しました。"
      @comment = Comment.new
      @comments = @review.comments.page(params[:page]).order(created_at: :desc)
      render 'public/reviews/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to review_path(comment.review_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :review_id, :body)
  end
end
