Rails.application.routes.draw do
  resources :boxes do
    resources :snippets
  end
  root 'boxes#public_index'
  devise_for :users

  get 'token', to: 'tokens#show'

  get 'v', to: 'tokens#validate'

  get 'box_feed', to: 'boxes#public_json'

  namespace :admin do
    resources :users, only: [:index, :new, :create]
  end

  namespace :api do
    get 'test', to: 'requests#test'
    get 'boxes', to: 'requests#boxes'
    get 'snippets', to: 'requests#snippets'
    post 'login', to: 'requests#login'
    post 'invite', to: 'requests#invite'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
