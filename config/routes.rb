Rails.application.routes.draw do
  root to: "homes#top"
  get 'about' => "homes#about"
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    get 'wish_lists/index'
  
    get 'followers/index'
  
    get 'reviews/show'
    get 'reviews/new'
  
    get 'books/index'
    get 'books/show'
    
    get 'mypage' => 'users#mypage'
    get 'information' => 'users#information'
    get 'information/edit' => 'users#edit'
    patch 'information/edit' => 'users#update'
    get 'unsubscribe' => 'users#unsubscribe'
    patch 'withdraw' => 'users#withdraw'
    get 'users/show/:id' => 'users#show'
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
