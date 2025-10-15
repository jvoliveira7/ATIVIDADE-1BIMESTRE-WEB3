Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  devise_for :admins
  resources :comments

  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"
  root to: "home#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
