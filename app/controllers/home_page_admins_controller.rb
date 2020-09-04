class HomePageAdminsController < ApplicationController 
 before_action :authenticate_admin! , :get_users 
 before_action :set_user, only: [:show_user, :destroy,:edit_user,:update_user]
 layout 'admin_layout'

	def index
		@admin=current_admin.first_name 
		@users=get_users
	end

	def show_user
	end

	def edit_user
	end

	def update_user
		
   	respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to show_user_by_admin_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to homepage_path , notice: 'User was Was not updated.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
 	end

	def destroy
		if @user.destroy 
		  respond_to do |format|
		  format.html { redirect_to homepage_path, notice: 'User was successfully destroyed.' }
		  format.json { head :no_content }
		  end
		end
	end
	
private

	def get_users
  		@users=User.all
  	end

  	def set_user
      @user = User.find(params[:id])
    end
	
	def user_params
      params.permit(:first_name,:middle_name,:last_name,:email,:country,:phone_number,:image)
    end
end
