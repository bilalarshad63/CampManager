class CampsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_locations, only: [:new]
  before_action :set_camp, only: %i[show edit update destroy toggle_status]
  layout 'admin_layout', except: [:index, :introduction]


  def show; end

  def introduction
    @camp = Camp.find(params[:camp])
    render template: "camps/introduction.html.erb"
  end

  def index
    @camps = Camp.all
  end

  def new
    @camp = Camp.new
  end

  def toggle_status
    @camp.camp_status == 1 ? (@camp.camp_status = 0) : (@camp.camp_status = 1)
    if @camp.save
      redirect_to homepage_camps_path
    end
  end

  def edit; end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: 'Camp was successfully created.' 
    else
      render :new 
    end
  end

  def edit
  end

  def update
    if @camp.update(camp_params)
      redirect_to homepage_camps_path, notice: 'Camp was successfully updated.' 
    else
      render :edit 
    end
  end

  def destroy
    @camp.destroy
    redirect_to homepage_camps_path, notice: 'Camp was successfully destroyed.' 
  end

  private

    def set_camp
      @camp = Camp.find(params[:id])
    end

    def get_locations
      @locations = CampLocation.all
    end

    def camp_params
      params.require(:camp).permit(:camp_title, :camp_type,:camp_status, :applicant_registration_start_date, :applicant_registration_end_date, :applicant_registration_start_time, :applicant_registration_end_time, :parent_application_start_date, :parent_application_end_date, :parent_application_start_time, :parent_application_end_time,camp_location_ids:[])
    end
end
