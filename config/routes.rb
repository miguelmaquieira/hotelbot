Rails.application.routes.draw do

  get 'profile/index'

  #devise_for :users
  get 'home/welcome' => 'home#welcome'

  get 'profile/show_styles' => 'profile#show_styles'
  get 'profile/show_whishlists' => 'profile#show_whishlists'
  get 'profile/show_deals' => 'profile#show_deals'
  get 'profile/show_groups' => 'profile#show_groups'
  get 'profile/show_settings' => 'profile#show_settings'
  get 'profile/create' => 'profile#create'
  get 'profile/hotel_styles_new' => 'profile#hotel_styles_new'
  post 'profile/hotel_styles_new' => 'profile#hotel_styles_create'
  post 'profile/basic_info' => 'profile#basic_info'
  get 'profile/add_to_wishlist/:id' => 'profile#add_to_wishlist'
  get 'profile/add_new_hotel_style' => 'profile#add_new_hotel_style'


  resources :hotels

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#welcome'

  # Facebook connect
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", :registrations =>'users/registrations' }

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
