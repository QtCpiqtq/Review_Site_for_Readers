class Public::ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def new
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @reviews = Review.new
  end
  
  def create
    @book = Book.find_or_create_by(isbn: params[:isbn])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    
    if @review.save
      flash[:notice] = "success"
      redirect_to mypage_path(current_user)
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end
  
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to mypage_path(current_user)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:evolution, :feeling_after_reading, :body)
  end
end
