Rails.application.routes.draw do
  resources :tasks
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resource :profiles, only: [:edit, :update]

  root 'tasks#index'
end
