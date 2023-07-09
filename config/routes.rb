Rails.application.routes.draw do
  resources :tasks
  resource :profiles, only: [:edit, :update]
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root 'tasks#index'
end
