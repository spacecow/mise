Rails.application.routes.draw do
  resources :articles, only:[:show,:index,:create]
  resources :galleries, only:[:show,:create]
  resources :images, only: :create
end
