class Moderator::DashboardController < Moderator::BaseController
  def index
    # Encontra os IDs dos questionários que pertencem ao moderador logado
    questionnaire_ids = current_user.questionnaires.pluck(:id)

    # Carrega todas as tentativas (resultados) para esses questionários
    @attempts = Attempt.where(questionnaire_id: questionnaire_ids).includes(:user, :questionnaire).order(created_at: :desc)
  end
end