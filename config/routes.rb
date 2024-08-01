Rails.application.routes.draw do
  root to: "homes#top"
  get 'about' => "homes#about"
  
  devise_for :users,
  skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    get 'mypage/:id' => 'users#mypage', as: 'mypage'
    get 'information' => 'users#information'
    get 'information/edit' => 'users#edit'
    patch 'information/edit' => 'users#update'
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdraw' => 'users#withdraw'
    delete 'image_destroy' => 'users#destroy'
    post 'guest_login', to: 'users#guest_login'
    
    resources :books, only: [:index]
    get 'books/search' => 'books#search'
    get 'books/:isbn', to: "books#show", as: "book"
    resources :reviews, only: [:show, :destroy]
    get 'books/:isbn/reviews/new', to: "reviews#new", as: "new_book_review"
    post 'books/:isbn/reviews', to: "reviews#create", as: "book_reviews"
    
    post 'reviews/:review_id/comments' => 'comments#create', as: 'review_comments'
    delete 'reviews/comments/:id' => 'comments#destroy', as: 'review_comment'
    
    post "reviews/:review_id/goods", to: "goods#create", as: "goods"
    delete "reviews/:review_id/goods", to: "goods#destroy", as: "good"
    
    resources :favorite_books, only: [:create, :destroy]
    
    resources :wish_lists, only: [:create, :destroy]
    get 'mypage/:id/wish_lists/index' => 'wish_lists#index', as: 'wish_lists_index'
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
   
  scope module: :admin do
    get "admin_reviews", to: "reviews#index", as: "admin_reviews"
    get "admin_review/:id", to: "reviews#show", as: "admin_review"
    get "admin_users", to: "users#index", as: "admin_users"
    get "admin_users/:id", to: "users#show", as: "admin_user"
    put "admin_users/:id", to: "users#update", as: "admin_user_update"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
