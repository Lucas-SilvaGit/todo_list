Rails.application.routes.draw do
  resources :tasks
  resource :profiles, only: [:edit, :update]
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root 'tasks#index'
end
