class Moderator::DashboardController < Moderator::BaseController
  def index
    # 1. Pega os IDs de todos os questionários que o moderador atual criou
    questionnaire_ids = current_user.questionnaires.pluck(:id)

    # 2. Busca todas as tentativas (resultados) que correspondem a esses questionários
    @attempts = Attempt.where(questionnaire_id: questionnaire_ids).includes(:user, :questionnaire).order(created_at: :desc)
  end
end