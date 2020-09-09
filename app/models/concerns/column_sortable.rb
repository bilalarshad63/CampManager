module Concerns::ColumnSortable
  extend ActiveSupport::Concern

  include do
    helper_method :sort_column, :sort_direction
  end

  private
  
  def sort_column
    CampLocation.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
