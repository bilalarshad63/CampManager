class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    @user.skip_password_validation = true
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path, notice: 'User was successfully updated.' }        
      else
        format.html { redirect_to homepage_path, notice: @user.errors }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation image date_of_birth gender]
  end
end