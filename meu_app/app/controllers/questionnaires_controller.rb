class QuestionnairesController < ApplicationController
  before_action :authenticate_user! # Adicionado: Garante que o usuário esteja logado
  before_action :set_questionnaire, only: %i[ show edit update destroy ]

  # GET /questionnaires
  def index
    @questionnaires = policy_scope(Questionnaire) # Modificado: Usa o scope do Pundit
  end

  # GET /questionnaires/1
  def show
    authorize @questionnaire # Adicionado: Verifica se o usuário pode ver este questionário
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    authorize @questionnaire # Adicionado: Verifica se o usuário pode criar um questionário
  end

  # GET /questionnaires/1/edit
  def edit
    authorize @questionnaire # Adicionado: Verifica se o usuário pode editar este questionário
  end

  # POST /questionnaires
  def create
    @questionnaire = current_user.questionnaires.build(questionnaire_params) # Modificado: Associa ao usuário
    authorize @questionnaire # Adicionado: Verifica a permissão de criação

    if @questionnaire.save
      redirect_to @questionnaire, notice: "Questionnaire was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questionnaires/1
  def update
    authorize @questionnaire # Adicionado: Verifica a permissão de edição
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: "Questionnaire was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questionnaires/1
  def destroy
    authorize @questionnaire # Adicionado: Verifica a permissão de exclusão
    @questionnaire.destroy!
    redirect_to questionnaires_url, notice: "Questionnaire was successfully destroyed."
  end

  private
    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    def questionnaire_params
      params.require(:questionnaire).permit(:code, :title, :description, :duration_minutes, :user_id)
    end
end