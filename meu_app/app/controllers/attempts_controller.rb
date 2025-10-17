class AttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: [:new, :create]

  def new
    @attempt = @questionnaire.attempts.build
  end

  def create
    # 1. Inicia uma nova tentativa para o usuário atual
    @attempt = @questionnaire.attempts.new(user: current_user)

    # 2. Pega as respostas enviadas pelo formulário
    submitted_answers = answers_params[:answers]
    score = 0

    # 3. Loop para salvar cada resposta e calcular a pontuação
    submitted_answers.each do |question_id, option_id|
      # Cria o registro da resposta do aluno
      @attempt.answers.build(
        question_id: question_id,
        option_id: option_id
      )

      # Verifica se a opção escolhida é a correta
      option = Option.find(option_id)
      if option.correct?
        score += 1
      end
    end

    # 4. Salva a pontuação final na tentativa
    @attempt.score = score

    if @attempt.save
      # 5. Redireciona para a página de resultado
     redirect_to [@questionnaire, @attempt], notice: "Questionário finalizado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Encontra a tentativa finalizada para mostrar o resultado
    @attempt = Attempt.find(params[:id])
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def answers_params
    # Permite que o hash 'answers' seja recebido com segurança
    params.require(:attempt).permit(answers: {})
  end
end