class HomePageAdminsController < ApplicationController 
	
 skip_before_action :verify_authenticity_token 

 before_action :authenticate_admin! , :get_users 
 before_action :set_user, only: [:show_user, :destroy,:edit_user,:update_user]
 layout 'admin_layout'

	def index
		@users=get_users
		@userss=User.all
		respond_to do |format|
	    format.html
	    format.csv do
	      headers['Content-Disposition'] = "attachment; filename=\"user-list\""
	      headers['Content-Type'] ||= 'text/csv'
	    end
	  end
	end

	def new_user
		@user=User.new
	end

	def create_user
		@user=User.new(user_params)
	    @user.skip_password_validation = true
	    @user.skip_confirmation!
	    respond_to do |format|
		    if @user.save
		    	@user.invite!
		      format.html { redirect_to homepage_path, notice: 'User was successfully Created.' }
		      format.json { render :show, status: :ok, location: @user }
		    else
		      format.html { redirect_to homepage_path , notice: @user.errors }
		      format.json { render json: @user.errors, status: :unprocessable_entity }
		    end
	  end
  end
	
	def show_user
	end

	def edit_user
	end

	def update_user		
		@user.skip_password_validation = true
   	respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to show_user_by_admin_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to homepage_path , notice: @user.errors }
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
		@users=User.order(:last_name).page(params[:page])
  end

	def set_user
    @user = User.find(params[:id])
  end
	
	def user_params
    params.require(:user).permit(:first_name,:middle_name,:last_name,:email,:country,:phone_number,:password,:password_confirmation,:image)
  end
end
