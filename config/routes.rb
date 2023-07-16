Rails.application.routes.draw do
  resources :tasks
  resource :profiles, only: [:edit, :update]
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  } 

  root 'tasks#index'
end
