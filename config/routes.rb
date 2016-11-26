Rails.application.routes.draw do
  root 'homes#index'

  resources :users do
    collection do
      get 'login'
    end
  end

  resources :homes do
    resources :comments
  end

  #resources :comments do
   # resources :comments
  #end
end
