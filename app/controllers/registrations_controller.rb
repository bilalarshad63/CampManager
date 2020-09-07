class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource
    if params[:agreement] == 'no'
      resource.assign_attributes(sign_up_params)
      flash.now[:danger] = 'You did not agree to the below listed terms and conditions.
      Please contact Admin at xyz@campmanager.com'
      render :new
    else
      super
    end
  end

  private

  def sign_up_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation]
  end

  def account_update_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation current_password]
  end
end
