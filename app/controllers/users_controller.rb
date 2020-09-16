class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit update]
  # layout 'admin_layout', except: %i[edit profile update]
  before_action :authenticate_user!, only: [:index]


  def index
    @user = current_user
  end

  def show; end

  def edit; end

  def update
    @user.skip_password_validation = true
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to homepage_path, notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to homepage_path, notice: 'User was successfully Destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation image date_of_birth gender image]
  end
end
