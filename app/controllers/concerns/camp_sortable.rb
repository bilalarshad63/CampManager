module Concerns::CampSortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_camp_column, :sort_camp_direction
  end

  def sort_camp_column
     return model_class_camp.column_names.include?(params[:sort]) ? params[:sort] : "camp_title" if model_class_camp.name == "Camp"
  end

  def sort_camp_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
