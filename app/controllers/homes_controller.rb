class HomesController < ApplicationController
  def top
    @popular_books = Book.all.sort {|a,b| 
    b.reviews.size <=> 
    a.reviews.size
    }.first(3)
    @popular_reviews = Review.all.sort {|a,b| 
    b.goods.size <=> 
    a.goods.size
    }.first(3)
    @latest_reviews = Review.order(created_at: :desc).first(3)
  end

  def about
  end
end
