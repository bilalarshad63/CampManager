module AdminPanel
  class HomePageAdminsController < ApplicationController
    include Concerns::ColumnSortable

    before_action :authenticate_admin!
    helper_method :sort_column, :sort_direction
    skip_before_action :verify_authenticity_token
    layout 'admin_layout'

    def index
      @users = User.search(params[:search]).order(sort_column => sort_direction).page(params[:page])
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = 'attachment; filename="user-list.csv"'
          headers['Content-Type'] ||= 'text/csv'
        end
      end
    end

    def model_class
      User
    end
  end
end
