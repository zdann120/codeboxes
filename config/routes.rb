Rails.application.routes.draw do
  get 'static/test'

  resources :boxes do
    resources :snippets
  end
  
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :new, :create]
  end

  post 'auth_user' => 'authentication#authenticate_user'
  root 'boxes#public_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
