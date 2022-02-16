Rails.application.routes.draw do
  root 'pages#home'

  ########## shopping_carts ##########
  resources :shopping_carts, only: [:show, :index]

  ########## users ##########
  resources :users, except: [:new]
  # sign up GET request routes for the users controller new action
  get 'signup', to: 'users#new'

  ########## products ##########
  resources :products
end
