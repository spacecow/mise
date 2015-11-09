Rails.application.routes.draw do
  resources :articles, only:[:show,:index,:create,:edit,:update]
  resources :galleries, only:[:show,:create]
  resources :images, only: :create
end
