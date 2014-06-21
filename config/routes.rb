Rails.application.routes.draw do
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

    concern :data do
        get :data, on: :collection
    end

    concern :search do
        get :search, on: :collection
    end

    # Collection routes
    devise_for :users, controllers: {:registrations => "users/registrations"}

    # Quickfix: devise omniauth routes do not support dynamic segments
    devise_scope :user do
        get "/login" => "devise/sessions#new"
        delete "/logout" => "devise/sessions#destroy"
        get "/register" => "users/registrations#new"

        match "/users/auth/:provider",
            constraints: { provider: /google_oauth2|facebook/ },
            to: "users/omniauth_callbacks#passthru",
            as: :omniauth_authorize,
            via: [:get, :post]
        match "/users/auth/:action/callback",
            constraints: { action: /google_oauth2|facebook/ },
            to: "users/omniauth_callbacks",
            as: :omniauth_callback,
            via: [:get, :post]
    end


    resources :users, concerns: [:photos, :reviews, :data, :search]
    get "/account" => "users#show", as: :account

    resources :carts, concerns: [:photos, :reviews, :tags, :categories, :data, :search] do
        member do
            resource :menu, only: [:show, :edit, :update, :destroy] do
                resource :menu_ghosts, path: "ghost_items", shallow: true
                resource :menu_items, path: "items", shallow: true
            end

            resources :ads, shallow: true
        end
    end

    resources :cart_ghosts, concerns: [:photos, :tags, :categories, :data, :search]

    devise_for :owners, controllers: {:registrations => "owners/registrations"}

    resources :owners do
        resources :carts, shallow: true
    end

    resources :ad_types

    resources :photos, only: [:show, :edit, :update, :destroy]

    resources :reviews, only: [:show, :edit, :update, :destroy],
        concerns: [:data, :search]

    resources :tags, only: [:edit, :update, :destroy] do
        member do
            get "carts" => "tags#carts"
        end
    end

    resources :categories, only: [:edit, :update, :destroy] do
        member do
            get "carts" => "categories#carts"
        end
    end

    resources :uploads

    namespace :mobile do
        devise_scope :user do
            post 'sessions' => 'sessions#create', :as => 'mobile_login'
            delete 'sessions' => 'sessions#destroy', :as => 'mobile_logout'
            post 'registrations' => 'registrations#create', :as => 'mobile_register'
        end
    end

    # Search
    get "/search" => "search#index", as: :search

    # Root page
    root to: "home#index", as: :home
end
