Rails.application.routes.draw do
  root 'homes#index'

  resources :users do
    collection do
      post 'login'
      get 'logout'
      get 'reset_password'
      post 'send_reset_password_email'
    end

    member do
      get 'update_password'
      post 'change_password'
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
      post 'add_comment'
    end
  end
end
