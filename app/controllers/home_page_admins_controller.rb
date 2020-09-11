class HomePageAdminsController < ApplicationController

  include Concerns::ColumnSortable

  before_action :authenticate_admin!
  helper_method :sort_column, :sort_direction
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[show_user destroy edit_user update_user]
  layout 'admin_layout'

  def index
    @users = User.search(params[:search]).order(sort_column => sort_direction).page(params[:page])
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"user-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    @user.skip_password_validation = true
    @user.skip_confirmation!
    if @user.save
      @user.invite!
      redirect_to homepage_path, notice: 'User was successfully Created.'         
    else
      redirect_to homepage_path, notice: @user.errors           
    end
  end

  def model_class
    User
  end
  
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit %i[first_name middle_name last_name email country phone_number password password_confirmation image search]
  end

end
