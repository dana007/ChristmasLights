Rails.application.routes.draw do
  root 'homes#index'
  
  
  
  resources :homes do
    resources :comments
  end

  #resources :comments do
   # resources :comments
  #end
end
