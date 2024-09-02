Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    get 'registration_type', to: 'users/registrations#registration_type'
    post 'registration_type', to: 'users/registrations#registration_type'
  end

  # Usuários podem ser empresas ou usuários comuns
  resources :users do
    get 'complaints', to: 'complaints#user_complaints', as: 'user_complaints'
    get 'companies', to: 'companies#user_companies', as: 'user_companies'
  end

  # Empresas podem ter reclamações e respostas
  resources :companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :complaints do
      resources :responses
    end
  end

  get 'top_companies', to: 'companies#top_scored_companies', as: 'top_companies'

  resources :complaints do
    get 'new_complaint', on: :collection, to: 'complaints#new_complaint'
  end

  get 'search', to: 'search#index', as: 'search'
  match 'registration_type', to: 'registrations#registration_type', via: [:get, :post]

  # TWILIO
  post "sms", to: "pages#sms"
  post "whatsapp", to: "pages#whatsapp"

  # Static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'faq', to: 'pages#faq'

end
