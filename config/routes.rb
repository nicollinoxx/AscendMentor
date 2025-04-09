Rails.application.routes.draw do
  resources :registrations, only: %i[ new create ]

  resources :sessions, only: %i[ index new create destroy ]

  resources :passwords, param: :token

  namespace :identity do
    resources :profiles, param: :name, only: %i[ index show ]
    resources :accounts, only: %i[ show edit update ]
    resources :avatars,  only: %i[ edit update destroy ]
    resources :tags,     except: %i[ index show ]
  end

  post "chats/:guest", to: "chats#create", as: :create_chat
  resources :chats, only: %i[ index destroy ] do
    resources :messages, except: %i[ new show ]
  end

  root "chats#index"
end
