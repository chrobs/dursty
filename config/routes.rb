Dursty::Application.routes.draw do

  devise_for :users

  resources :items
  resources :shop_bundles
  resources :order

  # kasse
  get "kasse/uebersicht"
  match "kasse/:id" => 'kasse#show_konto', :as => "kasse_show_konto"
  resource :konto_transaction
  #match "konto_transaction/new/:from" => "konto_transaction#new"

  # shop
  get "shop/index"
  get "shop/buy"
  match "shop/add_to_card/:bundle/:amount" => 'shop#addToCard', :as => :shop_add_to_card
  match "shop/remove_from_card/:bundle" => 'shop#removeFromCard', :as => :shop_remove_from_card

  # userkonto
  match "userkonto/:id" => 'userkonto#show', :as => :userkonto_show

  # order
  match "order/:id/update/:bundle/:amount" => 'order#update_bundle_amount', :as => :order_update_bundle_amount
  match "order/:id/delete/:bundle" => 'order#delete_bundle', :as => :order_delete_bundle

  # home
  get "home/index"

  # public
  get "public/index"

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => 'public#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
