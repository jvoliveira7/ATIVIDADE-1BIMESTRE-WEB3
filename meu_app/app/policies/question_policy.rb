class QuestionPolicy < ApplicationPolicy
  # Um usuário pode criar uma nova pergunta?
  def create?
    # Sim, se ele tiver permissão para atualizar o questionário ao qual a pergunta pertence.
    # Isso cobre tanto o admin (pode tudo) quanto o moderador (só pode o seu).
    Pundit.policy(user, record.questionnaire).update?
  end

  def new?
    create?
  end

  # As regras para editar e destruir uma pergunta são as mesmas de criar.
  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end
end