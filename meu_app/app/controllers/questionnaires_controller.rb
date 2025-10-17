class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: %i[ show edit update destroy ]

  # GET /questionnaires
  def index
    @questionnaires = policy_scope(Questionnaire)
  end

  # GET /questionnaires/1
  def show
    authorize @questionnaire
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    authorize @questionnaire
  end

  # GET /questionnaires/1/edit
  def edit
    authorize @questionnaire
  end

  # POST /questionnaires
  def create
    @questionnaire = current_user.questionnaires.build(questionnaire_params)
    authorize @questionnaire

    if @questionnaire.save
      redirect_to @questionnaire, notice: "Questionnaire was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questionnaires/1
  def update
    authorize @questionnaire
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: "Questionnaire was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questionnaires/1
  def destroy
    authorize @questionnaire
    @questionnaire.destroy!
    redirect_to questionnaires_url, notice: "Questionnaire was successfully destroyed."
  end

  private

    def set_questionnaire
      # VERSÃO CORRIGIDA E LIMPA: Apenas uma linha, a mais completa.
      @questionnaire = Questionnaire.includes(questions: :options).find(params[:id])
    end # Fim do método set_questionnaire

    def questionnaire_params
      # VERSÃO CORRIGIDA E MAIS SEGURA: sem o user_id
      params.require(:questionnaire).permit(:code, :title, :description, :duration_minutes)
    end # Fim do método questionnaire_params

end # Fim da classe QuestionnairesController