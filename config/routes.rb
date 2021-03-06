Merchants::Application.routes.draw do
  devise_for :users

  resources :payments, :categories,
    :line_items, :carts, :products, :orders, :users
  
  resources :bills, except: [:destroy] do
    get :print, on: :member
  end
  
  match 'store' => 'store#index', :via => 'get' 
  match 'monthlies' => 'monthlies#index', via: 'get'
  
  resources :clients do
    get :autocomplete_for_client, on: :collection
  end

  resources :boxes do
    get :print_close, on: :collection
  end

  root :to => 'store#index'
end
