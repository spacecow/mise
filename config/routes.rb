Rails.application.routes.draw do
  resources :articles, only:[:show,:index,:create,:edit,:update]
  resources :article_forms, path: :articles
  resources :images, only: :create
end
