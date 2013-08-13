Callisto::Application.routes.draw do


  resources :settings

  resources :sessions, only: [:new, :create, :destroy]
  resources :feedbacks, only: [:create]

  root to: 'users#home'

  match '/404',  to: 'static_pages#page404', as: 'page404'
  match '/500',  to: 'static_pages#page500', as: 'page500'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new', :as => 'signin'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/util/render/video/', to: 'util#ajax_auto_html', as: 'render_video'


  match '/friends/requests', to: 'friendships#requests'
  resources :friends, :controller => 'friendships' do
    get 'invite'
    get 'approve'
    get 'block'
    get 'deny'
  end
  

  


  match '/user_activities/:id/privacy', to: 'user_activities#privacy_state', as: 'user_activities_privacy_state'
  resources :users do
  	get 'wall'
    resources :user_activities, path: 'activities' do
      get 'accept'
      get 'forfeit'
      get 'complete'
    end
  end 


  match '/activities/filter' => 'activities#filter'
  match '/activities/filter_tags' => 'activities#filter_tags'
  match '/activities/accepted', to: 'users#accepted'
  match '/activities/completed', to: 'users#completed'
  match '/activities/forfeited', to: 'users#forfeited'
  resources :activities


  

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
