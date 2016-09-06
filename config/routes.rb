Rails.application.routes.draw do
  resources :boxes do
    resources :snippets
  end
  root 'boxes#public_index'
  devise_for :users

  get 'token', to: 'tokens#show'

  get 'v', to: 'tokens#validate'

  namespace :admin do
    resources :users, only: [:index, :new, :create]
  end

  namespace :api do
    get 'test', to: 'snippets#test'
    get 'boxes', to: 'snippets#boxes'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
