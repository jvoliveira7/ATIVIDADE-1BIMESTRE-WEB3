class Admin::DashboardController < Admin::BaseController
  def index
    @total_users = User.count
    @total_questionnaires = Questionnaire.count
    @total_results = UserResult.count
  end
end
