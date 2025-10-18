Rails.application.routes.draw do
  # 🌐 PÁGINA PRINCIPAL
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  # 👥 AUTENTICAÇÃO (Devise)
  devise_for :users

  # 🧩 CONTEÚDO PÚBLICO (Exemplo)
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # 🧠 QUESTIONÁRIOS E TENTATIVAS (Fluxo principal)
  resources :questionnaires do
    resources :attempts, only: [:new, :create, :show]
    resources :questions, shallow: true do
      resources :options, shallow: true
    end
  end

  # 🧑‍💼 ÁREA DO MODERADOR (Professor)
  authenticate :user, ->(u) { u.role&.title.in?(%w[admin moderator]) } do
    namespace :moderator do
      root to: "dashboard#index", as: :root
      resources :results, only: [:index, :show]
    end
  end

  # 👑 ÁREA ADMINISTRATIVA
  authenticate :user, ->(u) { u.role&.title == "admin" } do
    namespace :admin do
      root to: "dashboard#index", as: :root
      resources :users
      resources :questionnaires
      resources :results, only: [:index, :show]
    end
  end

  # ✉️ LETTER OPENER (somente em desenvolvimento)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end