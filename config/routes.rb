Rails.application.routes.draw do
 
 resources :articles
 
 #we say except because new was already mapped with signup
 resources :users, except: [:new]
 #by typing home the routes manageger will send us to the home page in the pages views/pages folder.
  get 'home',  to: 'pages#home'
 
  get 'about', to: 'pages#about'
 
  get 'signup',     to: 'users#new'
  
  
  # this is the login route
   get 'login',      to: 'sessions#new'
  
  #this will post of login form
  post 'login',     to: 'sessions#create'
 
  #this will logout the user
  delete 'logout',  to: 'sessions#destroy'
 
  root 'pages#home'
  
  #the except destroy prevents deletion of categories
  resources :categories, except: [:destroy]
  
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
