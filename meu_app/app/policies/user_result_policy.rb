# app/policies/user_result_policy.rb
class UserResultPolicy < ApplicationPolicy
  def index?
    user.role.title.in?(%w[admin moderator])
  end

  def show?
    user.role.title == 'admin' || user.role.title == 'moderator' || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      case user.role.title
      when 'admin'
        scope.all
      when 'moderator'
        # Apenas resultados de questionários que o moderador criou
        scope.joins(:questionnaire).where(questionnaires: { user_id: user.id })
      when 'student'
        # Apenas os próprios resultados
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end
end
