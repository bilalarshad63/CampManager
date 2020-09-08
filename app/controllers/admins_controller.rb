class AdminsController < ApplicationController

  before_action :set_user, only: [:edit,:update,:show]
  layout 'admin_layout'

  def show
  end

  def edit
  end

  def update
    @admin.skip_password_validation = true
  	respond_to do |format|
      if @admin.update(admin_params)
        bypass_sign_in(@admin)
        format.html { redirect_to admin_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { redirect_to homepage_path , notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_user
  	@admin =  current_admin
  end

  def admin_params
    params.require(:admin).permit(:first_name,:middle_name,:last_name,:email,:phone_number,:password,:password_confirmation,:image)
  end

end
