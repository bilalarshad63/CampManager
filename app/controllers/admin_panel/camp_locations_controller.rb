module AdminPanel
  class CampLocationsController < ApplicationController
    require 'csv'
    include Concerns::ColumnSortable
    before_action :set_location, only: %i[show edit update destroy]
    before_action :new_location, only: [:new]
    layout 'admin_layout'

    def index
      @camp_locations = CampLocation.search(params[:search]).order(sort_column => sort_direction).page(params[:page])
    end

    def new; end

    def edit; end

    def create
      @camp_location = CampLocation.new(camp_location_params)
      if @camp_location.save!
        redirect_to admin_panel_camp_location_path(@camp_location), alert: 'Camp location created successfully.'
      else
        redirect_to new_admin_panel_camp_location_path, alert: @camp_location.errors
      end
    end

    def show; end

    def destroy
      @camp_location.destroy!
      redirect_to admin_panel_camp_locations_path
    end

    def update
      if @camp_location.update!(camp_location_params)
        redirect_to admin_panel_camp_location_path(@camp_location), alert: 'Camp location updated successfully.'
      else
        render 'edit'
      end
    end

    def export_csv
      @camp_location = CampLocation.all
      respond_to do |format|
        format.html
        format.csv { send_data @camp_location.to_csv, filename: "camp_locations-#{Date.today}.csv" }
      end
    end

    def model_class
      CampLocation
    end

    private

    def new_location
      @camp_location = CampLocation.new
    end

    def set_location
      @camp_location = CampLocation.find(params[:id])
    end

    def camp_location_params
      params.require(:camp_location).permit(:name)
    end
  end
end
