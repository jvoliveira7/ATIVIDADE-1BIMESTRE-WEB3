    # app/controllers/admin/results_controller.rb
    class Admin::ResultsController < Admin::BaseController
      before_action :set_attempt, only: [:show]
    
      def index
        # Usa Pundit para pegar os resultados (tentativas) corretos para o usuário atual
        @attempts = policy_scope([:admin, Attempt])
      end
    
      def show
        # Usa Pundit para garantir que o usuário pode ver este resultado específico
        authorize [:admin, @attempt]
      end
    
      private
    
      def set_attempt
        @attempt = Attempt.find(params[:id])
      end
    end