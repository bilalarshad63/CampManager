module AdminPanel
  class CampsController < ApplicationController
    include Concerns::CampSortable
    layout 'admin_layout'
    before_action :authenticate_admin!
    before_action :set_camp, only: %i[show edit update destroy toggle_status]
    helper_method :sort_camp_column, :sort_camp_direction

    def index
      @camps = Camp.search(params[:search]).order(sort_camp_column => sort_camp_direction).page(params[:page])
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = 'attachment; filename="camps-list.csv"'
          headers['Content-Type'] ||= 'text/csv'
        end
      end
    end

    def show; end

    def new
      @camp = Camp.new
      @locations = CampLocation.all
    end

    def create
      @camp = Camp.new(camp_params)
      if @camp.save
        redirect_to admin_panel_camp_path(@camp), notice: 'Camp was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @camp.update(camp_params)
        redirect_to admin_panel_camps_path, notice: 'Camp was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @camp.destroy
      redirect_to admin_panel_camps_path, notice: 'Camp was successfully destroyed.'
    end

    def toggle_status
      @camp.camp_status == 'active' ? (@camp.camp_status = 'inactive') : (@camp.camp_status = 'active')
      @camp_status = @camp.camp_status if @camp.save
    end

    def model_class_camp
      Camp
    end

    private

    def set_camp
      @camp = Camp.find(params[:id])
    end

    def new_camp_application
      @camp_application = CampApplication.where(user_id: current_user.id, camp_id: @camp.id).first
    end

    def camp_params
      params.require(:camp).permit(:camp_title, :camp_type, :camp_status, :applicant_registration_start_date, :applicant_registration_end_date, :applicant_registration_start_time, :applicant_registration_end_time, :parent_application_start_date, :parent_application_end_date, :parent_application_start_time, :parent_application_end_time, camp_location_ids: [])
    end
  end
end
