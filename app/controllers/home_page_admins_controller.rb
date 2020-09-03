class HomePageAdminsController < ApplicationController
 before_action :authenticate_admin! , :get_users 
 before_action :set_user, only: [:show_user, :destroy]
 layout 'admin_layout'

	def index
		@admin=current_admin.first_name 
		@users=get_users
	end

	def show_user
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
	
end
