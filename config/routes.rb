Rails.application.routes.draw do
  resources :registrations, only: %i[ new create ]

  resource  :session
  get "sessions", to: "sessions#index"

  resources :passwords, param: :token

  namespace :identity do
    resources :profiles, param: :name, only: %i[ index show ]
    resources :accounts, only: %i[ show edit update ]
    resources :avatars,  only: %i[ edit update destroy ]
  end

  post "chats/:guest", to: "chats#create", as: :create_chat
  resources :chats, only: %i[ index destroy ] do
    resources :messages, except: %i[ new show ]
  end

  root "chats#index"
end
