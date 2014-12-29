Rails.application.routes.draw do
  get 'activities/index'

  resources :activities
  resources :images

  # devise_for :users

  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  root to: 'documents#find_my_root'

  resources :users do
    resources :documents do
      resources :images do
        resources :comments
      end
    end
  end

  resources :documents do
    resources :images
  end

  resources :images do
    resources :comments
  end


 # /users/20/documents/40/images/22

 #post 'annotations' => 'annotations#create'

  post '/users/:user_id/documents/:document_id/images/:image_id/annotations' => 'annotations#create'
  get '/users/:user_id/documents/:document_id/images/:image_id/annotations' => 'annotations#index'
  get '/users/:user_id/documents/:document_id/images/:image_id/annotations/:id' => 'annotations#show'
  delete '/users/:user_id/documents/:document_id/images/:image_id/annotations/:id' => 'annotations#destroy'
  put '/users/:user_id/documents/:document_id/images/:image_id/annotations/:id' => 'annotations#update'

  post '/users/:user_id/documents/:document_id/images/:image_id/comments/:id' => 'comments#update'


  # get 'users/:id', to: 'users#show', as: 'user'
  # get 'users/', to: 'users#index', as: 'all_user'
  # get '/patients/:id', to: 'patients#show', as: 'patient'
  # get 'users/' => 'users#index'

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
