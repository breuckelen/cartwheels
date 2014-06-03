Rails.application.routes.draw do
  resources :authentications

    # Concerns
    concern :photos do
        resources :photos, only: [:index, :new, :create]
    end

    concern :reviews do
        resources :reviews, only: [:index, :new, :create]
    end

    concern :tags do
        resources :tags, path: "tags", only: [:index, :new, :create]
    end

    concern :categories do
        resources :categories, path: "categories", only: [:index, :new, :create]
    end

    # Collection routes
    devise_for :users

    resources :users, concerns: [:photos, :reviews]
    get "/account", to: "users#show", as: :account

    resources :carts, concerns: [:photos, :reviews, :tags, :categories] do
        member do
            resource :menu, only: [:show, :edit, :update, :destroy] do
                resource :menu_ghosts, path: "ghost_items", shallow: true
                resource :menu_items, path: "items", shallow: true
            end

            resources :ads, shallow: true
        end
    end

    resources :cart_ghosts, concerns: [:photos, :tags, :categories]

    resources :owners do
        resources :carts, shallow: true
    end

    resources :ad_types

    resources :photos, only: [:show, :edit, :update, :destroy]

    resources :reviews, only: [:show, :edit, :update, :destroy]

    resources :tags, only: [:edit, :update, :destroy] do
        member do
            get "carts", to: "tags#carts"
        end
    end

    resources :categories, only: [:edit, :update, :destroy] do
        member do
            get "carts", to: "categories#carts"
        end
    end

    # Search
    get "/search", to: "search#index", as: :search

    # Root page
    root to: "home#index", as: :home

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
