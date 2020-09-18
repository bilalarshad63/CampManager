class CampApplicationsController < ApplicationController
  before_action :set_camp_application, only: %i[edit update]
  def profile
    @camp_application = CampApplication.where(user_id: current_user.id, camp_id: params[:camp_id]).first
  end

  def edit
    session[:application_step] = params[:param1] if params[:param1].present?
    @camp_application.current_step = session[:application_step]
  end

  def update
    if session[:application_step] == 'personal_info'
      current_user.skip_password_validation = true
      current_user.update(user_params)
    else
      @camp_application.update(camp_application_params)
    end
    @camp_application.current_step = session[:application_step]
    if params[:back_button]
      @camp_application.previous_step
    else
      @camp_application.next_step
    end
    session[:application_step] = @camp_application.current_step
    if params[:complete_button]
      redirect_to profile_camp_application_path(@camp_application.id, @camp_application.camp_id)
    else
      redirect_to edit_camp_application_path(@camp_application)
    end
  end

  private

  def set_camp_application
    @camp_application = CampApplication.find(params[:id])
  end

  def camp_application_params
    params.require(:camp_application).permit %i[education camp_preferences technology_requirements social_media]
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email phone_number date_of_birth gender]
  end
end
