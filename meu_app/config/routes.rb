Rails.application.routes.draw do

  resources :options
  resources :questions
  resources :questionnaires do
  resources :attempts, only: [:new, :create, :show]
  end
  devise_for :users
  get "home/index"
  resources :comments

  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
