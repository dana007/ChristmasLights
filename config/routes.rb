Rails.application.routes.draw do
  root 'home#index'
  resources :user_form, :controller => 'user'
end
