Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
end
