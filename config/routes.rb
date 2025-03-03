Rails.application.routes.draw do
  resources :registrations, only: %i[ new create ]
  resource  :session
  resources :passwords, param: :token
  resources :chats do
    resources :messages, except: %i[ new show ]
  end

  root "chats#index"
end
