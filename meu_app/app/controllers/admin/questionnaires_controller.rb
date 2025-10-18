module Admin
  class QuestionnairesController < Admin::BaseController
    before_action :set_questionnaire, only: %i[show edit update destroy]

    layout "admin"

    def index
      if current_user.admin?
        @questionnaires = Questionnaire.all
      else
        # Moderador só vê os questionários que ele criou
        @questionnaires = Questionnaire.where(user_id: current_user.id)
      end
    end

    def show; end

    def new
      @questionnaire = Questionnaire.new
    end

    def create
      @questionnaire = current_user.admin? ? Questionnaire.new(questionnaire_params) : current_user.questionnaires.new(questionnaire_params)

      if @questionnaire.save
        redirect_to admin_questionnaires_path, notice: "Questionário criado com sucesso."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize_owner!
    end

    def update
      authorize_owner!
      if @questionnaire.update(questionnaire_params)
        redirect_to admin_questionnaires_path, notice: "Questionário atualizado com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize_owner!
      @questionnaire.destroy
      redirect_to admin_questionnaires_path, notice: "Questionário excluído com sucesso."
    end

    private

    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    def questionnaire_params
      params.require(:questionnaire).permit(:title, :description)
    end

    def authorize_owner!
      unless current_user.admin? || @questionnaire.user_id == current_user.id
        redirect_to admin_questionnaires_path, alert: "Acesso negado."
      end
    end
  end
end
