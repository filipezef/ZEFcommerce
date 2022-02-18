Rails.application.routes.draw do
  ########## pages ##########
  root 'pages#home'

  ########## shopping_carts ##########
  resources :shopping_carts, only: [:show, :index]
  # checkout (select payment method and set checked_in = true)
  get 'payment', to: 'shopping_carts#payment'
  post 'shopping_carts/:id/checkout' => 'shopping_carts#checkout', as: 'shopping_cart_checkout'
  post 'shopping_carts/:id/add_to_cart' => 'shopping_carts#add_to_cart', as: 'shopping_cart_add_to_cart'

  ########## product_shopping_carts ##########
  # product_shopping_cart's controller routes, shopping_cart instanced by action current_cart, at application controller
  # reference:
  # https://github.com/howardmann/Tutorials/blob/master/Rails_Shopping_Cart.md
  post 'product_shopping_carts/:id/add' => 'product_shopping_carts#add_quantity', as: 'product_shopping_cart_add'
  post 'product_shopping_carts/:id/reduce' => 'product_shopping_carts#reduce_quantity', as: 'product_shopping_cart_reduce'
  get 'product_shopping_carts/:id' => 'product_shopping_carts#show', as: 'product_shopping_cart'
  delete 'product_shopping_carts/:id' => 'product_shopping_carts#destroy'

  ########## users ##########
  resources :users, except: [:new]
  # sign up GET request routes for the users controller new action
  get 'signup', to: 'users#new'

  ########## sessions ##########
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # routes to allow setting product quantity prior to adding it to the shopping cart
  post 'sessions/add' => 'sessions#add_quantity', as: 'session_add'
  post 'sessions/reduce' => 'sessions#reduce_quantity', as: 'session_reduce'

  ########## products ##########
  resources :products

  ########## categories ##########
  resources :categories
end
