# meu_app/app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # ADICIONE ESTE BLOCO para tratar erros de autorização do Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Bloco existente para permitir os campos personalizados do Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  private # O método de tratamento de erro deve ser privado

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para realizar esta ação."
    redirect_back(fallback_location: root_path)
  end

  protected # O método de configuração do Devise deve ser protegido

  def configure_permitted_parameters
    # Permite os campos no formulário de cadastro (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :suap_id, :role_id])

    # Permite os mesmos campos na tela de edição de perfil
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :suap_id, :role_id])
  end
end