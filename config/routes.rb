Rails.application.routes.draw do
  resources :csessions

  resources :visits

  resources :policies

  resources :pollsections

  resources :surveys

  resources :pollitems

  resources :polls

  resources :followships

  resources :theses

  resources :books

  resources :operacts

  resources :recipients

  resources :friendships

  resources :rankings

  resources :sub_categories

  resources :categories

  resources :goods

  resources :labs

  resources :taggings

  resources :courses

  resources :preports

  resources :tasks

  resources :assignments

  resources :partnerships

  resources :projects

  resources :votes

  resources :answers

  resources :questions

  resources :seekings

  resources :blogs

  resources :involvements

  resources :participations

  resources :groupings

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

  #devise_for :users
  devise_for :users, skip: [:sessions], controllers: { cas_sessions: 'our_cas_sessions' }
  root to: "home#index"
  match "/registeration_steps" => "home#registeration_steps", :via => :get
  match "/profiles/crop/:id" => "profiles#crop", :via => :get
  match "/profiles/upload_avatar/:id" => "profiles#upload_avatar", :via => :get

  match "/channels/change_avatar/:id" => "channels#change_avatar", :via => :get
  match "/channels/crop/:id" => "channels#crop", :via => :get
  match "/channels/upload_avatar/:id" => "channels#upload_avatar", :via => :get
  match "/channels/view_content/:id" => "channels#view_content", :via => :get
  match "/channels/join/:id" => "channels#join", :via => :get
  match "/channels/search/:id" => "channels#search", :via => :get
  match "/channels/cropper/:id" => "channels#cropper", :via => :get


  match "/groups/change_avatar/:id" => "groups#change_avatar", :via => :get
  match "/groups/crop/:id" => "groups#crop", :via => :get
  match "/groups/upload_avatar/:id" => "groups#upload_avatar", :via => :get
  match "/groups/view_content/:id" => "groups#view_content", :via => :get
  match "/groups/search/:id" => "groups#search", :via => :get
  match "/groups/cropper/:id" => "groups#cropper", :via => :get

  match "/events/change_avatar/:id" => "events#change_avatar", :via => :get
  match "/events/crop/:id" => "events#crop", :via => :get
  match "/events/upload_avatar/:id" => "events#upload_avatar", :via => :get
  match "/events/view_content/:id" => "events#view_content", :via => :get
  match "/events/search/:id" => "events#search", :via => :get
  match "/events/cropper/:id" => "events#cropper", :via => :get

  match "/messages/view_content/:id" => "messages#view_content", :via => :get

  match "/profiles/search/:id" => "profiles#advanced_search", :via => :get

  match "/groupings/add_to_group/:id" => "groupings#add_to_group", :via => :get
  match "/groupings/change_stat/:id" => "groupings#change_stat", :via => :get
  match "/groupings/make_admin/:id" => "groupings#make_admin", :via => :get

  match "/comments/xedit/:id" => "comments#xedit", :via => :get
  match "/comments/render_partial/:id" => "comments#render_partial", :via => :get


  match "/participations/add_to_event/:id" => "participations#add_to_event", :via => :get
  match "/participations/change_stat/:id" => "participations#change_stat", :via => :get
  match "/participations/make_admin/:id" => "participations#make_admin", :via => :get

  match "/involvements/add_to_channel/:id" => "involvements#add_to_channel", :via => :get
  match "/involvements/change_stat/:id" => "involvements#change_stat", :via => :get
  match "/involvements/make_admin/:id" => "involvements#make_admin", :via => :get

  match "/blogs/view_content/:id" => "blogs#view_content", :via => :get
  match "/blogs/join/:id" => "blogs#join", :via => :get
  match "/blogs/search/:id" => "blogs#search", :via => :get

  match "/notes/view_content/:id" => "notes#view_content", :via => :get

  match "/profiles/view_content/:id" => "profiles#view_content", :via => :get
  match "/profiles/profile_search/:id" => "profiles#search", :via => :get
  match "/profiles/cropper/:id" => "profiles#cropper", :via => :get

  match "/messages/view_content/:id" => "messages#view_content", :via => :get
  match "/messages/compose/:id" => "messages#compose", :via => :get

  match "/questions/view_content/:id" => "questions#view_content", :via => :get
  match "/questions/search/:id" => "questions#search", :via => :get

  match "/votes/vote_up/:id" => "votes#vote_up", :via => :get
  match "/votes/vote_down/:id" => "votes#vote_down", :via => :get

  match "/tags/remoteq/:id" => "tags#remoteq", :via => :get

  match "/profiles/remoteq/:id" => "profiles#remoteq", :via => :get

  match "/projects/view_content/:id" => "projects#view_content", :via => :get
  match "/projects/cropper/:id" => "projects#cropper", :via => :get
  match "/projects/search/:id" => "projects#search", :via => :get

  match "/partnerships/add_to_project/:id" => "partnerships#add_to_project", :via => :get

  match "/preports/remote_preport/:id" => "preports#remote_preport", :via => :get


  match "/courses/change_avatar/:id" => "courses#change_avatar", :via => :get
  match "/courses/crop/:id" => "courses#crop", :via => :get
  match "/courses/upload_avatar/:id" => "courses#upload_avatar", :via => :get
  match "/courses/view_content/:id" => "courses#view_content", :via => :get
  match "/courses/search/:id" => "courses#search", :via => :get
  match "/courses/cropper/:id" => "courses#cropper", :via => :get

  match "/labs/change_avatar/:id" => "labs#change_avatar", :via => :get
  match "/labs/crop/:id" => "labs#crop", :via => :get
  match "/labs/upload_avatar/:id" => "labs#upload_avatar", :via => :get
  match "/labs/view_content/:id" => "labs#view_content", :via => :get
  match "/labs/search/:id" => "labs#search", :via => :get
  match "/labs/cropper/:id" => "labs#cropper", :via => :get

  match "/categories/subs/:id" => "categories#subs", :via => :get

  match "/goods/search/:id" => "goods#search", :via => :get
  match "/goods/view_content/:id" => "goods#view_content", :via => :get

  match "/researches/view_content/:id" => "researches#view_content", :via => :get

  match "/rankings/remote/:id" => "rankings#remote", :via => :get

  match "/friendships/add_friend/:id" => "friendships#add_friend", :via => :get
  match "/friendships/remove_friend/:id" => "friendships#remove_friend", :via => :get

  match "/followships/follow/:id" => "followships#follow", :via => :get
  match "/followships/unfollow/:id" => "followships#unfollow", :via => :get

  match "/polls/completion/:id" => "polls#completion", :via => :get
  match "/polls/view_content/:id" => "polls#view_content", :via => :get

  post 'upload' => 'upload#create'
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
