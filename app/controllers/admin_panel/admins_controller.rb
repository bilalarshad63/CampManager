module AdminPanel
  class AdminsController < ApplicationController
    layout 'admin_layout'

    def show; end

    def edit; end

    def update
      current_admin.skip_password_validation = true
      if current_admin.update(admin_params)
        bypass_sign_in(current_admin)
        redirect_to admin_panel_admin_path, notice: 'User was successfully updated.'
      else
        redirect_to admin_panel_homepage_path, notice: current_admin.errors
      end
    end

    private

    def admin_params
      params.require(:admin).permit(:first_name, :middle_name, :last_name, :email, :phone_number, :password, :password_confirmation, :image)
    end
  end
end
