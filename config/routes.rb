Rails.application.routes.draw do
  resources :students
  resources :sessions
  resources :attendances
  resources :search
  root 'landing_page#index'
end
