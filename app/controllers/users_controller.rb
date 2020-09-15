class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit update personal_info save_personal_info profile]
  # layout 'admin_layout', except: %i[edit profile update]
  before_action :authenticate_user!, only: [:index]

  def index 
    @user = current_user
  end

  def show; end

  def edit
    if current_admin.nil?
      @user.current_step = session[:user_step]
      render 'edit'
    else
      render 'admin_user_edit'
    end
  end

  def profile; end

  def update
    @user.skip_password_validation = true
    if current_admin.nil?
      @user.update(user_params)
      @user.current_step = session[:user_step]
      if params[:back_button]
        @user.previous_step
      else
        @user.next_step
      end
      session[:user_step] = @user.current_step
      if params[:complete_button]
        redirect_to profile_user_path(@user.id)
      else
        redirect_to edit_user_path(@user.id)
      end
    else
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
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation image education camp_preference tech_reqs date_of_birth gender image]
  end
end
