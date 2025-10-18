class HomeController < ApplicationController
  def index
    if current_user&.role&.title == "admin"
     redirect_to admin_root_path

    end
  end
end
