Rails.application.routes.draw do
  resources :articles, only: :show
  resources :galleries, only: :create
end
