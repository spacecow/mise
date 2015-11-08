Rails.application.routes.draw do
  resources :articles, only: :show
  resources :galleries, only:[:show,:create]
  resources :images, only: :create
end
