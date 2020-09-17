class CampApplicationsController < ApplicationController
  def profile
    @user = current_user
    @camp_application = CampApplication.find(params[:id])
  end

  def edit
    @user = current_user
    @camp_application = CampApplication.find(params[:id])
    @camp_application.current_step = session[:application_step]
  end

  def update
    @camp_application = CampApplication.find(params[:id])
    #  	@camp_application.update(camp_application_params)
    @camp_application.current_step = session[:application_step]
    if params[:back_button]
      @camp_application.previous_step
    else
      @camp_application.next_step
    end
    session[:application_step] = @camp_application.current_step
    if params[:complete_button]
      redirect_to profile_camp_application_path(@camp_application.id)
    else
      redirect_to edit_camp_application_path(@camp_application)
    end
  end

  private

  def camp_application_params
    params.require(:camp_application).permit %i[education camp_preference technology_requirements social_media]
  end
end
