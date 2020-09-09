# module Concerns::ColumnSortable
#   extend ActiveSupport::Concern

#   included do
#     helper_method :sort_column, :sort_direction
#   end

#   private
  
#   def sort_column
#     model_class.column_names.include?(params[:sort]) ? params[:sort] : "name" if model_class == "User"
#     model_class.column_names.include?(params[:sort]) ? params[:sort] : "name" if model_class == "CampLocation"
#   end

#   def sort_direction
#     %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
#   end
# end
