Rails.application.routes.draw do
  resources :boxes do
    resources :snippets
  end
  root 'boxes#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
