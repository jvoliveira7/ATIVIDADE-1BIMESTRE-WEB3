class QuestionnairePolicy < ApplicationPolicy
  # Todos os usuários logados podem ver a lista de questionários
  def index?
    true
  end

  # Todos os usuários logados podem ver os detalhes de um questionário
  def show?
    true
  end

  # Apenas admins e moderadores podem criar questionários
  def create?
    user.role.title == 'admin' || user.role.title == 'moderator'
  end

  # A mesma regra de 'create?' se aplica a 'new'
  def new?
    create?
  end

  # Admins podem editar qualquer questionário.
  # Moderadores só podem editar os que eles mesmos criaram.
  def update?
    user.role.title == 'admin' || record.user == user
  end

  # A mesma regra de 'update?' se aplica a 'edit'
  def edit?
    update?
  end

  # A mesma regra de 'update?' se aplica a 'destroy'
  def destroy?
    update?
  end

  class Scope < Scope # <-- AQUI ESTÁ A CORREÇÃO
    def resolve
      scope.all # Por enquanto, todos podem ver todos os questionários na lista
    end
  end
end