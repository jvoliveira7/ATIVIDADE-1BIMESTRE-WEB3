class Admin::BaseController < ApplicationController
  before_action :authenticate_user!    # Garante que o usuário esteja logado
  before_action :check_admin           # <-- Aqui estava o erro, antes era authorize_admin

  def check_admin
    unless current_user.role&.title.in?(%w[admin moderator])
      redirect_to root_path, alert: "Acesso negado: apenas administradores ou moderadores podem acessar esta área."
    end
  end
end
