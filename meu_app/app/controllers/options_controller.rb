class OptionsController < ApplicationController
  before_action :set_option, only: %i[ show edit update destroy ]

  # GET /options
  def index
    @options = Option.all
  end

  # GET /options/1
  def show
    authorize @option
  end

  # GET /options/new
  def new
    # Encontra a pergunta pai usando o ID que passamos na URL
    @question = Question.find(params[:question_id])
    # Cria uma nova opção já associada a esta pergunta
    @option = @question.options.build
    authorize @option
  end

  # GET /options/1/edit
  def edit
    authorize @option
  end

  # POST /options
  def create
    @option = Option.new(option_params)
    authorize @option

    if @option.save
      # Redireciona para o questionário da pergunta pai.
      redirect_to @option.question.questionnaire, notice: "Opção adicionada com sucesso."
    else
      # Se a validação falhar, recarrega @question para a view 'new' funcionar
      @question = Question.find(option_params[:question_id])
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /options/1
  def update
    authorize @option

    if @option.update(option_params)
      redirect_to @option, notice: "Opção atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /options/1
  def destroy
    authorize @option
    @option.destroy!
    redirect_to options_url, notice: "Opção excluída com sucesso."
  end

  private

    def set_option
      @option = Option.find(params[:id])
    end

    def option_params
      params.require(:option).permit(:text, :correct, :question_id)
    end
end
