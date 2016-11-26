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
  end

  #resources :comments do
   # resources :comments
  #end
end
