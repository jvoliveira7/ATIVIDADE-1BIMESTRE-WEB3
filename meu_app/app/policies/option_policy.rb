class OptionPolicy < ApplicationPolicy
  # Um usuário pode criar uma opção?
  def create?
    # Ele pode criar uma opção se tiver permissão de atualizar a pergunta associada.
    Pundit.policy(user, record.question).update?
  end

  def new?
    create?
  end

  # Regras iguais para editar e excluir
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
