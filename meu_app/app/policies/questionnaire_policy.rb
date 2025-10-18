class QuestionnairePolicy < ApplicationPolicy
  # Todos os usuários logados podem ver a lista de questionários
  def index?
    true
  end

  # Todos os usuários logados podem ver detalhes de um questionário
  def show?
    true
  end

  # Apenas admins e moderadores podem criar questionários
  def create?
    user.admin? || user.moderator?
  end

  def new?
    create?
  end

  # Admin pode editar qualquer questionário
  # Moderador só pode editar os próprios
  def update?
    user.admin? || (user.moderator? && record.user == user)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        scope.where(user: user) # só os próprios questionários
      else
        scope.all # Alunos podem ver todos, mas não editar
      end
    end
  end
end
