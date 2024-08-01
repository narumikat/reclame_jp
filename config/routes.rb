Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    get 'registration_type', to: 'users/registrations#registration_type'
    post 'registration_type', to: 'users/registrations#registration_type'
  end

  resources :users 
  resources :enterprises, only: [:new, :create, :show, :edit, :update]
  
  # resources :users do 
  #   resources :enterprises, only: [:new, :create, :show, :edit, :update]
  # end
  
  resources :users do
    resources :complaints, only: [:new, :create, :index]
    resources :enterprises, only: [:index] do
      resources :employees, only: [:index]
    end
  end
end
