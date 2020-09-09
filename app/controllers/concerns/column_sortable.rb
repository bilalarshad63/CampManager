module Concerns::ColumnSortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  private
  
  def sort_column

    return model_class.column_names.include?(params[:sort]) ? params[:sort] : "username" if model_class.name == "User"
    return model_class.column_names.include?(params[:sort]) ? params[:sort] : "name" if model_class.name == "CampLocation"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
