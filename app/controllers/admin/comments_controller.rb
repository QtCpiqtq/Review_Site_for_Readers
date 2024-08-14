class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_review_path(@comment.review_id)
  end
end
