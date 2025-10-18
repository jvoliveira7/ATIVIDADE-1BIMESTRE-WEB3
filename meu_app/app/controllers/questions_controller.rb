class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    authorize @question
  end

  # GET /questions/new
  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @question = @questionnaire.questions.build
    authorize @question
  end

  # GET /questions/1/edit
  def edit
    authorize @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    authorize @question   # ✅ Autoriza antes de salvar

    if @question.save
      redirect_to @question.questionnaire, notice: "Pergunta adicionada com sucesso."
    else
      @questionnaire = Questionnaire.find(question_params[:questionnaire_id])
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    authorize @question   # ✅ Autoriza antes de atualizar

    if @question.update(question_params)
      redirect_to @question.questionnaire, notice: "Pergunta atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    authorize @question   # ✅ Autoriza antes de destruir

    @question.destroy!
    redirect_to @question.questionnaire, notice: "Pergunta removida com sucesso."
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:text, :questionnaire_id)
    end
end
