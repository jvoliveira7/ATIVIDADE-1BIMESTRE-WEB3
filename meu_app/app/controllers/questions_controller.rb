class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
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

  # POST /questions or /questions.json
def create
  @question = Question.new(question_params)

  if @question.save
    # MUDANÇA AQUI: Redireciona para o questionário pai, não para a pergunta
    redirect_to @question.questionnaire, notice: "Pergunta foi criada com sucesso."
  else
    render :new, status: :unprocessable_entity
  end
end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to questions_path, notice: "Question was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.expect(question: [ :text, :questionnaire_id ])
    end
end
