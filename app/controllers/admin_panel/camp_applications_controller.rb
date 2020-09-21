class AdminPanel::CampApplicationsController < ApplicationController
  layout 'admin_layout'
  before_action :set_camp_application, only: %i[show destroy]

  def index
    @camp_applications = CampApplication.all
  end

  def show; end

  def destroy
    @camp_application.destroy
    redirect_to admin_panel_camp_applications_path, notice: 'Camp Application was Successfully destroyed.'
  end

  private

  def set_camp_application
    @camp_application = CampApplication.find(params[:id])
  end
end
