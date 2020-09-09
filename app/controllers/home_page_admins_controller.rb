class HomePageAdminsController < ApplicationController
  helper_method :sort_column, :sort_direction
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin!, :get_users
  before_action :set_user, only: %i[show_user destroy edit_user update_user]
  layout 'admin_layout'

  def index
    @users = User.search(params[:search]).order(sort_column => sort_direction)
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    @user.skip_password_validation = true
    @user.skip_confirmation!
    respond_to do |format|
      if @user.save
        @user.invite!
        format.html { redirect_to homepage_path, notice: 'User was successfully Created.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to homepage_path, notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_user; end

  def edit_user; end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to show_user_by_admin_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to homepage_path, notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return unless @user.destroy

    respond_to do |format|
      format.html { redirect_to homepage_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def get_users
    @users = User.all
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password image search]
  end
end
