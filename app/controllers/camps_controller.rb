class CampsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  include Concerns::CampSortable
  before_action :get_locations, only: [:new]
  before_action :set_camp, only: %i[show edit update destroy toggle_status]
  helper_method :sort_camp_column, :sort_camp_direction

  # layout 'admin_layout', except: [:index, :introduction]
  def admin_camps
    @camps = Camp.search(params[:search]).order(sort_camp_column => sort_camp_direction).page(params[:page])
      render layout: 'admin_layout'
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = 'attachment; filename="camps-list.csv"'
          headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def index
   
      @camps = Camp.where(camp_status: 'Active')
      if @camps.count == 1
        @camp = @camps.first
        new_camp_application
        render template: 'camps/introduction.html.erb'
      else
        render 'index'
      end
    
  end

  def show; end

  def introduction
    @camp = Camp.find(params[:camp])
    new_camp_application
    render template: 'camps/introduction.html.erb'
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: 'Camp was successfully created.'
    else
      render :new
    end
  end

  def model_class_camp
    Camp
  end

  def toggle_status
    @camp.camp_status == 'Active' ? (@camp.camp_status = 'InActive') : (@camp.camp_status = 'Active')
    @camp_status = @camp.camp_status if @camp.save
  end

  def edit; end

  def update
    if @camp.update(camp_params)
      redirect_to camps_path, notice: 'Camp was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_path, notice: 'Camp was successfully destroyed.'
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end

  def get_locations
    @locations = CampLocation.all
  end

  def new_camp_application
    @camp_application = CampApplication.new
    @camp_application.user_id = current_user.id
    @camp_application.camp_id = @camp.id
    @camp_application.save
  end

  def camp_params
    params.require(:camp).permit(:camp_title, :camp_type, :camp_status, :applicant_registration_start_date, :applicant_registration_end_date, :applicant_registration_start_time, :applicant_registration_end_time, :parent_application_start_date, :parent_application_end_date, :parent_application_start_time, :parent_application_end_time, camp_location_ids: [])
  end
end
