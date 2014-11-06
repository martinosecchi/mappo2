Mappo2::Application.routes.draw do
  
  devise_for  :users,
              :controllers => { :registrations => "custom_devise/registrations"}

  root to: 'pages#home'
  match '/index', to: 'pages#index'
  match '/home', to: 'pages#home'
  match '/help', to: 'pages#help'

  match '/datasets/:id/locations', to: 'datasets#locations_of', :as => :locations_of
  match '/datasets/:id/map', to: 'datasets#dataset_map', :as => :dataset_map
  match '/datasets/:id/timeline', to: 'datasets#timeline', :as => :timeline
  match '/datasets/:id/geochart_region', to: 'datasets#geochart_region', :as => :geochart_region
  match '/datasets/:id/geochart_markers', to: 'datasets#geochart_markers', :as => :geochart_markers
  match '/datasets/:id/map/embed/embedmap', to: 'datasets#embedmap', :as => :embedmap
  match '/datasets/:id/timeline/embed/embedtimeline1', to: 'datasets#embedtimeline1', :as => :embedtimeline1
  match '/datasets/:id/timeline/embed/embedtimeline2', to: 'datasets#embedtimeline2', :as => :embedtimeline2


  resources :works, :except => :index do
    collection { post :import }
  end

  resources :locations, :except => [:index, :destroy]

  resources :datasets, :except => :index


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
