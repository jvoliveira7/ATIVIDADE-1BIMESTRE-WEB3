class OptionsController < ApplicationController
  before_action :set_option, only: %i[ show edit update destroy ]

  # GET /options
  def index
    @options = Option.all
  end

  # GET /options/1
  def show
  end

  # GET /options/new
  def new
    # Encontra a pergunta pai usando o ID que passamos na URL
    @question = Question.find(params[:question_id])
    # Cria uma nova opção já associada a esta pergunta
    @option = @question.options.build
  end

  # GET /options/1/edit
  def edit
  end

  # POST /options
  def create
    @option = Option.new(option_params)

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
    if @option.update(option_params)
      redirect_to @option, notice: "Option was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /options/1
  def destroy
    @option.destroy!
    redirect_to options_url, notice: "Option was successfully destroyed."
  end

  private
    def set_option
      @option = Option.find(params[:id])
    end

    # MÉTODO CORRIGIDO
    def option_params
      # VERSÃO CORRETA: Usa require e permit para segurança.
      params.require(:option).permit(:text, :correct, :question_id)
    end
end