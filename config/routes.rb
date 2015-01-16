Rails.application.routes.draw do
  get 'main/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :data_entry

  resources :reporting

  resources :allegiances do
    resources :systems
    resources :stations
  end

  resources :economies do
    resources :stations
  end

  resources :governments do
    resources :stations
  end

  resources :population_levels do
    resources :stations
  end

  resources :system_types do
    resources :systems
  end

  resources :systems do
    resources :stations
  end

  resources :station_types do
    resources :stations
  end

  resources :commodity_types do
    resources :commodities
  end

  resources :station_commodities do
    resources :stations
    resources :commodities
  end

  resources :stations do
    resource :station_commodities
  end

  resources :commodities do
    resource :station_commodities
  end

  resources :station_economies do
    resources :stations
    resources :economies
  end

  resources :stations do
    resource :station_economies
  end

  resources :economies do
    resource :station_economies
  end

  match 'stations/:id/buyers_for_supply' => 'stations#buyers_for_supply', via: [:get, :post]
  match 'stations/who_sells_commodity'   => 'stations#who_sells_commodity', via: [:get, :post]
  match 'stations/trade_routes'          => 'stations#trade_routes', via: [:get, :post]

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
