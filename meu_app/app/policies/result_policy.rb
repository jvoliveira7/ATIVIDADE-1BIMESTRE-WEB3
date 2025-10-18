# app/policies/result_policy.rb
class ResultPolicy < ApplicationPolicy
  def index?
    true # todos logados podem acessar a lista, mas a scope filtra o que veem
  end

  def show?
    # Admin vê tudo, Moderador só os próprios questionários, Aluno só os próprios resultados
    user.admin? ||
      (user.moderator? && record.questionnaire.user == user) ||
      (user.student? && record.user == user)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        # só resultados de questionários que o moderador criou
        scope.joins(:questionnaire).where(questionnaires: { user_id: user.id })
      else
        # Aluno só vê os próprios resultados
        scope.where(user: user)
      end
    end
  end
end
