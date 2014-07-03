Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    # Concerns
    concern :photos do
        resources :photos, only: [:index, :new, :create]
    end

    concern :reviews do
        resources :reviews, only: [:index, :new, :create]
    end

    concern :checkins do
        resources :checkins, only: [:index, :new, :create]
    end

    concern :ads do
        resources :ads, only: [:index, :new, :create]
    end

    concern :user_cart_relations do
        resources :user_cart_relations, path: "subscribers", only: [:index, :new, :create]
    end

    concern :cart_tag_relations do
        resources :cart_tag_relations, path: "tags", only: [:index, :new, :create]
    end

    concern :cart_category_relations do
        resources :cart_category_relations, path: "categories", only: [:index, :new, :create]
    end

    concern :data do
        get :data, on: :collection
    end

    concern :search do
        get :search, on: :collection
    end

    # Collection routes
    devise_for :users, controllers: {:registrations => "users/registrations",
        :sessions => "users/sessions"}

    devise_for :owners, controllers: {:registrations => "owners/registrations",
        :sessions => "owners/sessions"}

    # Quickfix: devise omniauth routes do not support dynamic segments
    devise_scope :user do
        get "/login" => "users/sessions#new"
        delete "/logout" => "users/sessions#destroy"
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

    # User routes
    resources :users, concerns: [:photos, :reviews, :checkins, :data, :search]
    get "/account" => "users#show", as: :account

    resources :owners, concerns: [:data] do
        resources :carts, only: [:index, :new, :create]
    end

    # Cart routes
    resources :carts, concerns: [:photos, :reviews, :checkins, :data, :search, :ads,
            :user_cart_relations, :cart_tag_relations, :cart_category_relations] do
        member do
            resource :menu do
                resources :menu_items, path: "items", only: [:index, :new, :create]
            end
        end
    end

    # Other public routes
    resources :photos, only: [:show, :edit, :update, :destroy],
        concerns: [:data]

    resources :reviews, only: [:show, :edit, :update, :destroy],
        concerns: [:data, :search]

    resources :tags, concerns: [:data]

    resources :categories, concerns: [:data]

    # Private routes
    resources :ads, only: [:show, :edit, :update, :destroy],
        concerns: [:data], path: "_ads"

    resources :ad_types, concerns: [:data], path: "_ad_types"

    resources :checkins, only: [:show, :edit, :update, :destroy],
        concerns: [:data, :search], path: "_checkins"

    resources :menu_items, only: [:show, :edit, :update, :destroy],
        concerns: [:data], path: "_menu_items"

    resources :user_cart_relations, only: [:show, :edit, :update, :destroy],
        concerns: [:data], path: "_cart_associations"

    resources :cart_tag_relations, only: [:show, :edit, :update, :destroy],
        concerns: [:data], path: "_tag_instances"

    resources :cart_category_relations, only: [:show, :edit, :update, :destroy],
        concerns: [:data], path: "_category_instances"

    resources :search_lines, concerns: [:data], path: "_search_lines"

    resources :clickthroughs, concerns: [:data], path: "_clickthroughs"

    namespace :mobile do
        devise_scope :user do
            post 'sessions' => 'sessions#create', :as => 'mobile_login'
            delete 'sessions' => 'sessions#destroy', :as => 'mobile_logout'
            post 'registrations' => 'registrations#create', :as => 'mobile_register'
        end

        devise_scope :owner do
            post 'owners/sessions' => 'sessions#create', :as => 'mobile_owner_login'
            delete 'owners/sessions' => 'sessions#destroy', :as => 'mobile_owner_logout'
            post 'owners/registrations' => 'registrations#create', :as => 'mobile_owner_register'
        end
    end

    # Search
    get "/search" => "search#index", as: :search

    # Root page
    root to: "home#index", as: :home
end
