Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  resources :pictures
end
