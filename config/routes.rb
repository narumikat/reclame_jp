Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    get 'registration_type', to: 'users/registrations#registration_type'
    post 'registration_type', to: 'users/registrations#registration_type'
  end

  # Usuários podem ser empresas ou usuários comuns
  resources :users

  # Empresas podem ter reclamações e respostas
  resources :companies do
    resources :complaints do
      resources :responses
    end
  end

  resources :complaints do
    get 'new_complaint', on: :collection, to: 'complaints#new_complaint'
  end

  # TWILIO
  post "sms", to: "pages#sms"
  post "whatsapp", to: "pages#whatsapp"

end
