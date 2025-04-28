Rails.application.routes.draw do
  resources :posts, only: [ :create ] do
    collection do
      get :top_posts
      get :ips_by_authors
    end
  end
  resources :ratings, only: [ :create ]
end
