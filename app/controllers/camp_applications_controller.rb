class CampApplicationsController < ApplicationController
  
  def profile
    @camp_application = CampApplication.where(user_id: current_user.id, camp_id: params[:camp_id]).first
    @user = current_user
  end

  def edit
    if(params[:param1].present?)
      session[:application_step]=params[:param1]
    end
    
    @user = current_user
    @camp_application = CampApplication.find(params[:id])
    @camp_application.current_step = session[:application_step]
  end

  def update
    @camp_application = CampApplication.find(params[:id])
    if session[:application_step] == 'personal_info'
      @user = current_user
      @user.skip_password_validation = true
      @user.update(user_params)
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

  def camp_application_params
    params.require(:camp_application).permit %i[education camp_preferences technology_requirements social_media]
  end

  def user_params
    #image
    params.require(:user).permit %i[first_name middle_name last_name email phone_number date_of_birth gender]
  end
end
