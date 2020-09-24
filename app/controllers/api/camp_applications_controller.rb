class Api::CampApplicationsController < ApplicationController
  def index
    @camp_applications = CampApplication.all
    render json: @camp_applications
  end

  def show
    @camp_application = CampApplication.find(params[:id])
    render json: @camp_application
  end
end
