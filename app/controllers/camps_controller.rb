class CampsController < ApplicationController
  before_action :authenticate_user!

  def index
    @camps = Camp.where(camp_status: 'Active')
    if @camps.count == 1
      @camp = @camps.first
      new_camp_application
      render template: 'camps/show.html.erb'
    else
      render 'index'
    end
  end

  def show
    @camp = Camp.find(params[:camp])
    new_camp_application
  end

  private

  def new_camp_application
    @camp_application = CampApplication.where(user_id: current_user.id, camp_id: @camp.id).first
    @camp_application = CampApplication.create(user_id: current_user.id, camp_id: @camp.id) if @camp_application.nil?
  end
end
