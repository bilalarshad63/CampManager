class CampApplicationsController < ApplicationController
  before_action :set_camp_application, only: %i[edit update auto_save]

  def profile
    @camp_application = CampApplication.find(params[:id])
  end

  def auto_save
    if session[:application_step] == 'personal_info'
      current_user.skip_password_validation = true
      current_user.update(user_params)
    else
      if session[:application_step] == 'education'
        @camp_application.education_check = false if params[:camp_application][:education].blank?
      end
      if session[:application_step] == 'camp_preference'
        @camp_application.camp_preferences_check = false if params[:camp_application][:camp_preferences].blank?
      end
      if session[:application_step] == 'technology_requirements'
        @camp_application.tech_requirements_check = false if params[:camp_application][:technology_requirements].blank?
      end
      if session[:application_step] == 'social_media'
        @camp_application.social_media_check = false if params[:camp_application][:social_media].blank?
      end
      @camp_application.update(camp_application_params)
    end
  end

  def show
    @camp_application = CampApplication.find(params[:id])
  end

  def edit
    if @camp_application.calculate_percentage == 100
      redirect_to profile_camp_application_path(camp_id: @camp_application.camp_id), alert: 'You have submitted Your Profile, Now can not Edit your Application'
    else
      session[:application_step] = params[:param1] if params[:param1].present?
      @camp_application.current_step = session[:application_step]
    end
  end

  def update
    if session[:application_step] == 'personal_info'
      current_user.skip_password_validation = true
      params[:user][:date_of_birth].present? && params[:user][:gender].present? ? @camp_application.personal_info_check = true : @camp_application.personal_info_check = false
      current_user.update(user_params)
      @camp_application.save
    else
      if session[:application_step] == 'education'
        params[:camp_application][:education].present? ? @camp_application.education_check = true : @camp_application.education_check = false
      end
      if session[:application_step] == 'camp_preference'
        params[:camp_application][:camp_preferences].present? ? @camp_application.camp_preferences_check = true : @camp_application.camp_preferences_check = false
      end
      if session[:application_step] == 'technology_requirements'
        params[:camp_application][:technology_requirements].present? ? @camp_application.tech_requirements_check = true : @camp_application.tech_requirements_check = false
      end
      if session[:application_step] == 'social_media'
        params[:camp_application][:social_media].present? ? @camp_application.social_media_check = true : @camp_application.social_media_check = false
      end
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
      redirect_to profile_camp_application_path(@camp_application.id, @camp_application.camp_id), notice: 'Application was submitted'
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
