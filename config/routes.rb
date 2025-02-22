Rails.application.routes.draw do
  resources :chats do
    resources :messages, except: %i[ new show ]
  end

  root "chats#index"
end
