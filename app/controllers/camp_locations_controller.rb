class CampLocationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    @camp_locations = CampLocation.order(sort_column => sort_direction) if sort_column && sort_direction.present?
    @camp_locations = CampLocation.search(params[:search]) if params[:search].present? 
  end

  def new
    @camp_location = CampLocation.new
  end

  def edit
    @camp_location = CampLocation.find(params[:id])
  end

  def create
    @camp_location = CampLocation.new(camp_location_params)
    if @camp_location.save
      redirect_to @camp_location, alert: 'Camp location created successfully.'
    else
      redirect_to new_camp_location_path, alert: 'Error creating camp location.'
    end
  end

  def show
    @camp_location = CampLocation.find(params[:id])
  end

  def destroy
    @camp_location = CampLocation.find(params[:id])
    @camp_location.destroy
    redirect_to camp_locations_path
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def camp_location_params
    params.require(:camp_location).permit(:name)
  end
end
