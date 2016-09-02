Rails.application.routes.draw do
  resources :boxes do
    resources :snippets
  end
  root 'boxes#public_index'
  devise_for :users

  namespace :admin do
    resources :users, only: [:index, :new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
