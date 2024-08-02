class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @message = "Bienvenue sur le dashboard administrateur"
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Vous n'avez pas les droits d'accès."
    end
  end
end
