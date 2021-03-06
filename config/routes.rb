Rails.application.routes.draw do
  resources :notifications
  resources :users, only: [:index, :destroy]
  get '/my_notifications', to: 'users#my_notifications'
  resources :user_notifications, only: [:index, :create]
  post '/user_notifications/:id/seen', to: 'user_notifications#mark_as_seen'
end
