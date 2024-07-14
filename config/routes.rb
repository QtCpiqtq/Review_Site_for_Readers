Rails.application.routes.draw do
  root to: "homes#top"
  get 'about' => "homes#about"
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  scope module: :public do
   
    resources :favorite_books, only: [:create, :destroy]
    
    get 'mypage/:id' => 'users#mypage', as: 'mypage'
    get 'information' => 'users#information'
    get 'information/edit' => 'users#edit'
    patch 'information/edit' => 'users#update'
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdraw' => 'users#withdraw'
    delete 'image_destroy' => 'users#destroy'
    
    resources :books, only: [:index]
    get 'books/search' => 'books#search'
    get 'books/:isbn', to: "books#show", as: "book"
    resources :reviews, only: [:show, :destroy]
    get 'books/:isbn/reviews/new', to: "reviews#new", as: "new_book_review"
    post 'books/:isbn/reviews', to: "reviews#create", as: "book_reviews"
    
    post 'reviews/:review_id/comments' => 'comments#create', as: 'review_comments'
    delete 'reviews/comments/:id' => 'comments#destroy', as: 'review_comment'
    
    resources :wish_lists, only: [:create, :destroy]
    get 'mypage/:id/wish_lists/index' => 'wish_lists#index', as: 'wish_lists_index'
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
   
  scope module: :admin do
    get 'reviews/index'
    get 'reviews/show'
  
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
