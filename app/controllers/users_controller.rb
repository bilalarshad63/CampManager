class UsersController < ApplicationController

	before_action :set_user, only: [:show, :destroy,:edit,:update]
	layout 'admin_layout'

	def show
	end

	def edit
	end

	def update	
		@user.skip_password_validation = true
    if @user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.' 
    else
      redirect_to homepage_path , notice: @user.errors 
    end
 	end

	def destroy
		if @user.destroy 
			redirect_to homepage_path, notice: 'User was successfully destroyed.'
			head :no_content 
		end
	end

	private

		def set_user
	    	@user = User.find(params[:id])
		end

		def user_params
  	params.require(:user).permit(:first_name,:middle_name,:last_name,:email,:country,:phone_number,:password,:password_confirmation,:image)
		end
end
