class Moderator::BaseController < ApplicationController
  before_action :authenticate_moderator!

  private

  def authenticate_moderator!
    # Permite o acesso se o usuário for moderador OU admin
    unless current_user.moderator? || current_user.admin?
      redirect_to root_path, alert: "Você não tem permissão para acessar esta área."
    end
  end
end