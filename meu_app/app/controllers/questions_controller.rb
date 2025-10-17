class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    # Encontra o questionário pai usando o ID que passamos na URL
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    # Cria uma nova pergunta já associada a este questionário
    @question = @questionnaire.questions.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      # Redireciona de volta para o questionário pai.
      redirect_to @question.questionnaire, notice: "Pergunta adicionada com sucesso."
    else
      # Recarrega o @questionnaire se houver um erro de validação
      @questionnaire = Questionnaire.find(question_params[:questionnaire_id])
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to @question, notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy!
    redirect_to questions_url, notice: "Question was successfully destroyed."
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    # MÉTODO CORRIGIDO
    def question_params
      # VERSÃO CORRETA: Usa require e permit para segurança.
      params.require(:question).permit(:text, :questionnaire_id)
    end
end