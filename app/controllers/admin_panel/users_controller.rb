module AdminPanel
  class UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: %i[show destroy edit update]
    layout 'admin_layout'

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.skip_password_validation = true
      @user.skip_confirmation!
      if @user.save!
        @user.invite!
        redirect_to admin_panel_homepage_path, notice: 'User was successfully Created.'
      else
        redirect_to admin_panel_homepage_path, notice: @user.errors
      end
    end

    def show; end

    def edit; end

    def update
      @user.skip_password_validation = true
      respond_to do |format|
        if @user.update!(user_params)
          format.html { redirect_to admin_panel_user_path, notice: 'User was successfully updated.' }
        else
          format.html { redirect_to admin_panel_homepage_path, notice: @user.errors }
        end
      end
    end

    def destroy
      if @user.destroy!
        respond_to do |format|
          format.html { redirect_to admin_panel_homepage_path, notice: 'User was successfully Destroyed.' }
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
end
