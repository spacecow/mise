Rails.application.routes.draw do
  resources :articles, only:[:show,:index,:create,:edit]
  resources :galleries, only:[:show,:create]
  resources :images, only: :create
end
