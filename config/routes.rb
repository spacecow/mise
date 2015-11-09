Rails.application.routes.draw do
  resources :articles, only:[:show,:index,:create,:edit,:update]
  resources :images, only: :create
end
