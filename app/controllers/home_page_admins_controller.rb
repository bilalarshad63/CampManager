class HomePageAdminsController < ApplicationController

 before_action :authenticate_admin! , :get_users
 layout 'admin_layout'

	def index
		@admin=current_admin.first_name 
		@users=get_users
	end

	def destroy
		@user=set_user
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
	
end
