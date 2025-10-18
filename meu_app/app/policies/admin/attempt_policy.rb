    class Admin::AttemptPolicy < ApplicationPolicy
      # O admin pode ver os detalhes de qualquer resultado?
      def show?
        user.role.title == 'admin'
      end
    
      class Scope < ApplicationScope
        def resolve
          if user.role.title == 'admin'
            # Se for admin, mostra TODOS os resultados (tentativas)
            scope.all
          elsif user.role.title == 'moderator'
            # Se for moderador, mostra apenas os resultados dos seus questionários
            # Isso requer que a gente consiga chegar do 'Attempt' até o 'user' do 'Questionnaire'
            scope.joins(:questionnaire).where(questionnaires: { user_id: user.id })
          end
        end
      end
    end
    
