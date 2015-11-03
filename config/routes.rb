Rails.application.routes.draw do

  resources :articles, only: :show

  resources :galleries, only:[:create,:edit,:update]
  resources :gallery_forms, path: :galleries

end
