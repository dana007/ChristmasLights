Rails.application.routes.draw do
  root 'homes#index'

  resources :users do
    collection do
      post 'login'
      get 'logout'
    end
  end

  resources :homes do
    resources :comments
    collection do
      get 'user_homes'
      get 'favorite_homes'
    end

    member do
      post 'update_rating'
      post 'update_favorites'
    end
  end

  #resources :comments do
   # resources :comments
  #end
end
