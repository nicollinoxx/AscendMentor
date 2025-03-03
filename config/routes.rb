Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :chats do
    resources :messages, except: %i[ new show ]
  end

  root "chats#index"
end
