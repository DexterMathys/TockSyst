Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :sign_out
  end

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  root :to => 'login#index'

  #Sector de stock

  get '/stock', to: 'productos#index'
  get '/stock/nuevo', to:'productos#new'
  get '/stock/lista', to: 'productos#list'
  get '/stock/ayuda', to: 'productos#ayuda'
  post '/stock/buscar', to: 'productos#buscar'
  post '/stock/edit', to:'productos#edit'
  post '/stock/update', to: 'productos#update'
  post '/stock/nuevo', to:'productos#create'
  post '/stock/eliminar', to: 'productos#destroy'
  post '/stock/alta', to: 'productos#alta'

  #Sector de proveedors

  get '/proveedors', to: 'proveedors#index'
  get '/proveedors/nuevo', to: 'proveedors#new'
  get '/proveedors/ayuda', to: 'proveedors#ayuda'
  post '/proveedors/nuevo', to: 'proveedors#create'
  post '/proveedors/eliminar', to: 'proveedors#destroy'
  post '/proveedors/alta', to: 'proveedors#alta'
  post '/proveedors/buscar', to: 'proveedors#buscar'
  post '/proveedors/edit', to: 'proveedors#edit'
  post '/proveedors/update', to: 'proveedors#update'

  #Sector de clientes

  get '/clientes', to: 'clientes#index'
  get '/clientes/nuevo', to: 'clientes#new'
  get '/clientes/ayuda', to: 'clientes#ayuda'
  post '/clientes/nuevo', to: 'clientes#create'
  post '/clientes/eliminar', to: 'clientes#destroy'
  post '/clientes/alta', to: 'clientes#alta'
  post '/clientes/buscar', to: 'clientes#buscar'
  post '/clientes/edit', to: 'clientes#edit'
  post '/clientes/update', to: 'clientes#update'

  #Sector de compras

  get '/compras', to: 'compras#index'
  get '/compras/nueva', to: 'compras#new'
  get '/compras/ayuda', to: 'compras#ayuda'
  post '/compras/nueva', to: 'compras#comprando'
  post '/compras/eliminar', to: 'compras#destroy'
  post '/compras/comprar', to: 'compras#create'
  post '/compras/buscar', to: 'compras#buscar'
  post '/compras/agregar', to: 'compras#agregar'
  post '/compras/eliminar', to: 'compras#destroy'
  post '/compras/buscar_compra_numero', to: 'compras#buscar_numero'
  post '/compras/buscar_compra_proveedor', to: 'compras#buscar_proveedor'
  post '/compras/buscar_compra_fecha', to: 'compras#buscar_fecha'
  post '/compras/show', to: 'compras#show'

  #Sector de ventas

  get '/ventas', to: 'ventas#index'
  get '/ventas/nueva', to: 'ventas#new'
  get '/ventas/ayuda', to: 'ventas#ayuda'
  post '/ventas/nueva', to: 'ventas#vendiendo'
  post '/ventas/eliminar', to: 'ventas#destroy'
  post '/ventas/vender', to: 'ventas#create'
  post '/ventas/buscar', to: 'ventas#buscar'
  post '/ventas/agregar', to: 'ventas#agregar'
  post '/ventas/eliminar', to: 'ventas#destroy'
  post '/ventas/buscar_venta_numero', to: 'ventas#buscar_numero'
  post '/ventas/buscar_venta_cliente', to: 'ventas#buscar_cliente'
  post '/ventas/buscar_venta_fecha', to: 'ventas#buscar_fecha'
  post '/ventas/show', to: 'ventas#show'

  #Sector de usuarios

  get '/usuarios', to: 'usuarios#index'
  post '/usuarios/update', to: 'usuarios#update'

  #get '/' => 'application#login'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
