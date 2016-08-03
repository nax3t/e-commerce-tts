Rails.application.routes.draw do
  root 'store_front#all_items'

  post 'add_to_cart' => 'cart#add_to_cart'
  get 'view_order' => 'cart#view_order'
  get 'checkout' => 'cart#checkout'

  devise_for :users

  get 'all' => 'store_front#all_items'
	get 'categorical' => 'store_front#items_by_category'
  get 'branding' => 'store_front#items_by_brand'

  resources :products
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
