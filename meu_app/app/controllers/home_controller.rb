class HomeController < ApplicationController
  def index
    if current_user&.role&.title == "admin"
      redirect_to admin_dashboard_path
    end
  end
end
