require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  resources :posts, only: [ :create ] do
    collection do
      get :top_posts
      get :ips_by_authors
    end
  end
  resources :ratings, only: [ :create ]
end
