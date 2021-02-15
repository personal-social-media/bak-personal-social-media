Rails.application.routes.draw do
  Rails.application.routes.default_url_options[:host] = Rails.application.secrets.dig(:load_balancer_address)

  root "home#index"
  get "/public_key", to: "static#public_key"
  get "/authorize_upload", to: "static#authorize_upload"
  post "/sign", to: "signatures#create"

  resources :profiles, path: "/u", only: :show do

  end

  resources :posts
  resources :previous_searches, only: %i(index create destroy)
  resources :image_albums, only: %i(index show create update destroy) do
    resources :gallery_elements, only: %i(index create)
  end

  resources :gallery_elements, only: :destroy do
    collection do
      get "/all_private_file_names", action: :all_private_file_names
      get "/all_md5_checksums", action: :all_md5_checksums
    end
  end

  resources :cities, only: %i(index)
  resources :identities, only: :create
  resources :peer_infos, only: %i(index show create update destroy) do
    collection do
      post "/search_public_keys", action: :search_public_keys
    end
  end

  resource :sessions, only: [] do
    collection do
      get "/profile", action: :profile
      patch "/profile_upload", action: :profile_post
      get "/settings", action: :settings

      get "/login", action: :login
      post "/login", action: :login_post

      get "/register", action: :register
      post "/register", action: :register_post

      delete "/logout", action: :logout

      get "/recovery", action: :recovery
      post "/recovery", action: :confirm_recovery
    end
  end

  namespace :api do
    post "/server_proof_of_work", to: "server_proof_of_works#show"

    resource :friendship, only: %i(show create destroy update)
    resource :profile, only: :show

    resources :posts, only: %i(show index) do
      resources :comments, only: %i(index show) do
        resources :reactions, only: %i(index create destroy)
      end
      resources :reactions, only: %i(index create destroy)
    end

    resources :stories, only: :show do
      resources :comments, only: %i(index show) do
        resources :reactions, only: %i(index create destroy)
      end
      resources :reactions, only: %i(index create destroy)
    end
  end

  namespace :client do
    resources :friendships, only: %i(create destroy update)
  end

  constraints LoggedIn do
    mount Sidekiq::Web => '/sidekiq' if ENV["DEVELOPER"].present?
    mount PgHero::Engine => "/pghero"
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin' if ENV["DEVELOPER"].present?
  end
end
