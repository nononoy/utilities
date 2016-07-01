Rails.application.routes.draw do

  root to: 'votings#index'
  resources :user_sessions
  resources :users do
    member do
      get :activate
    end
  end
  resources :password_resets

  get '/profile' => 'users#edit', as: :profile

  resources :votings
  resources :user_building_meters, only: [:upadate_all,:send_data, :create, :new, :index] do
    collection do
      patch :update_all
      patch :send_data
    end
  end
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  post '/voting_questions/:voting_question_id/accept'  => 'user_voting_questions#accept',  as: :accept_voting_question
  post '/voting_questions/:voting_question_id/discard' => 'user_voting_questions#discard', as: :discard_voting_question

  namespace :admin do
    get '/' => 'users#index'
    resources :users
    resources :buildings
  end

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
