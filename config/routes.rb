Rails.application.routes.draw do
  root 'store_front#all_items'

  post 'add_to_cart' => 'cart#add_to_cart'
  get 'view_order' => 'cart#view_order'
  get 'checkout' => 'cart#checkout'
  post 'order_complete' => 'cart#order_complete'
  delete 'empty_cart/:id' => 'cart#empty_cart', as: 'empty_cart'
  
  devise_for :users

  get 'all' => 'store_front#all_items'
	get 'categorical/:id' => 'store_front#items_by_category', as: 'categorical'
  get 'branding' => 'store_front#items_by_brand'

  resources :products
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
