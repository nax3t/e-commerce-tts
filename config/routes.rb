Rails.application.routes.draw do
  #Root path
  root 'store_front#all_items'
  
  #Cart routes
  post 'add_to_cart' => 'cart#add_to_cart'
  get 'view_order' => 'cart#view_order'
  get 'checkout' => 'cart#checkout'

  devise_for :users

  #Store_front routes
  get 'all' => 'store_front#all_items'
	get 'categorical' => 'store_front#items_by_category'
  get 'branding' => 'store_front#items_by_brand'

  #Restful routes
  resources :products
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
