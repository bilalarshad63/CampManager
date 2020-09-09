class HomePageAdminsController < ApplicationController
  helper_method :sort_column, :sort_direction
  include Concerns::ColumnSortable
  skip_before_action :verify_authenticity_token
  before_action :authenticate_admin!
  before_action :set_user, only: %i[show_user destroy edit_user update_user]
  before_action :get_camps, only: [:show_camps]
  layout 'admin_layout'

  def index
    @users = User.search(params[:search]).order(sort_column => sort_direction).page(params[:page])
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

	def show_camps
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

  def model_class
    User
  end

  private

  # def sort_column
  #   User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  # end

  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  # end

  def get_camps
    @camps=Camp.all
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation image search]
  end
end
