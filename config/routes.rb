Rails.application.routes.draw do
  resources :chats do
    resources :messages
  end

  root "chats#index"
end
