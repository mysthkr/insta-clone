Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit]
  resources :favorites, only: [:create, :destroy]
  resources :pictures do
    member do
      get 'favo', action: 'favo'
    end
    collection do
      post :confirm
    end
  end
end
