Rails.application.routes.draw do
  root to: "homes#top"
  get "about", to: "homes#about"
  
  devise_for :users,
  skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scope module: :public do
    get "users", to:  redirect("/users/sign_up")
    get "mypage/:id", to: "users#mypage", as: "mypage"
    get "information", to: "users#information"
    get "information/edit", to: "users#edit"
    patch "information/edit", to: "users#update"
    get "unsubscribe", to: "users#unsubscribe"
    patch "withdraw", to: "users#withdraw"
    delete "image_destroy", to: "users#destroy"
    post "guest_login", to: "users#guest_login"
    
    resources :books, only: [:index]
    get "books/search", to: "books#search"
    get "books/:isbn", to: "books#show", as: "book"
    resources :reviews, only: [:show, :destroy]
    get "books/:isbn/reviews/new", to: "reviews#new", as: "new_book_review"
    post 'books/:isbn/reviews', to: "reviews#create", as: "book_reviews"
    
    post "reviews/:review_id/comments" => "comments#create", as: "review_comments"
    delete "reviews/comments/:id" => "comments#destroy", as: "review_comment"
    
    post "reviews/:review_id/goods", to: "goods#create", as: "goods"
    delete "reviews/:review_id/goods", to: "goods#destroy", as: "good"
    
    resources :favorite_books, only: [:create, :destroy]
    
    resources :wish_lists, only: [:create, :destroy]
    get "mypage/:id/wish_lists/index", to: "wish_lists#index", as: "wish_lists_index"
    
    post "mypage/:id/relationships", to: "relationships#create", as: "relationships"
    delete "mypage/relationships/:user_id", to: "relationships#destroy", as: "relationship"
    get "mypage/:id/followings", to: "relationships#followings", as: "followings"
  	get "mypage/:id/followers", to: "relationships#followers", as: "followers"
  	get "users/index", to: "users#index", as: "users_index"
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get "reviews", to: "reviews#index", as: "reviews"
    get "review/:id", to: "reviews#show", as: "review"
    delete "review/:id", to: "reviews#destroy", as: "review_destroy"
    delete "comment/:id", to: "comments#destroy", as: "comment_destroy"
    get "users", to: "users#index", as: "users"
    get "users/:id", to: "users#show", as: "user"
    put "users/:id", to: "users#update", as: "user_update"
    resources :feeling_after_readings
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
