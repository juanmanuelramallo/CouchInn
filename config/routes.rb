Rails.application.routes.draw do


  get 'questions/edit'

  get 'questions/index'

  get 'messages/index'

  resources :qualifications

  get 'qualifications/index'

  get 'qualifications/show'

  get 'qualifications/new'

  get 'qualifications/create'

  get 'qualifications/destroy'

  get 'qualifications/edit'

  get 'qualifications/update'





  get 'layouts/informacion'

#corregido desde abajo en adelante ---

  resources :questions


  get '/contacto' => 'pages#contacto'

  get '/acercade' => 'pages#acercade'

  get '/ayuda' => 'pages#ayuda'


  resources :searchings

  get 'reservations/misreservas'

  get 'reservations/show'

  get 'reservations/main'

  get 'reservation/confirm' => 'reservations#confirm'

  resources :reservations

  resources :tipocs

  get 'tipocs/gestion'



  get 'payments/resumen'

  get 'payments/main'

  resources :payments

  get 'couches/missing'

  resources :couches

  get 'devise/registrations/show'

  devise_for :users
  resources :users, only: [:index]

  get 'main' => 'couches#main'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'couches#main'

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
