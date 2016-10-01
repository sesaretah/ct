Rails.application.routes.draw do
  resources :comments

  resources :events

  resources :groups

  resources :channels

  resources :notes

  resources :messages

  resources :tags

  resources :honors

  resources :researches

  resources :educations

  resources :profiles

  devise_for :users
  root to: "home#index"
  match "/registeration_steps" => "home#registeration_steps", :via => :get
  match "/profiles/crop/:id" => "profiles#crop", :via => :get
  match "/profiles/upload_avatar/:id" => "profiles#upload_avatar", :via => :get

  match "/channels/change_avatar/:id" => "channels#change_avatar", :via => :get
  match "/channels/crop/:id" => "channels#crop", :via => :get
  match "/channels/upload_avatar/:id" => "channels#upload_avatar", :via => :get
  match "/channels/view_content/:id" => "channels#view_content", :via => :get


  match "/groups/change_avatar/:id" => "groups#change_avatar", :via => :get
  match "/groups/crop/:id" => "groups#crop", :via => :get
  match "/groups/upload_avatar/:id" => "groups#upload_avatar", :via => :get
  match "/groups/view_content/:id" => "groups#view_content", :via => :get

  match "/events/change_avatar/:id" => "events#change_avatar", :via => :get
  match "/events/crop/:id" => "events#crop", :via => :get
  match "/events/upload_avatar/:id" => "events#upload_avatar", :via => :get
  match "/events/view_content/:id" => "events#view_content", :via => :get

  match "/messages/view_content/:id" => "messages#view_content", :via => :get


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
