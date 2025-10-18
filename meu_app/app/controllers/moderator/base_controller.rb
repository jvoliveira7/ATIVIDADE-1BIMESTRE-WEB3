class Moderator::BaseController < ApplicationController
  before_action :authenticate_moderator!

  private

  def authenticate_moderator!
    # Redireciona a menos que o usuário seja moderador OU admin (admin pode ver tudo)
    unless current_user.moderator? || current_user.admin?
      redirect_to root_path, alert: "Acesso negado."
    end
  end
end