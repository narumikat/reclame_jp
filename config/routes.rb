Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    get 'registration_type', to: 'users/registrations#registration_type'
    post 'registration_type', to: 'users/registrations#registration_type'
  end

  resources :users 
  resources :companies, only: [:new, :create, :show, :edit, :update]
  
  # resources :users do 
  #   resources :companies, only: [:new, :create, :show, :edit, :update]
  # end
  
  # resources :companies, only: [:new, :create, :show, :edit, :update]

  resources :users do
    resources :complaints, only: [:new, :create, :index]
    resources :companies, only: [:index] do
      resources :employees, only: [:index]
    end
  end

  resources :companies do
    resources :complaints, only: [:new, :create, :index]
  end
  
  resources :complaints, only: [:show] do
    resources :responses, only: [:create, :edit, :update]
  end
end
