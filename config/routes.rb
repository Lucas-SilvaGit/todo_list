Rails.application.routes.draw do
  resources :tasks
  resource :profiles, only: [:edit, :update]
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  get 'search', to: 'search#index'

  root 'tasks#index'
end
