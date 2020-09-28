class Api::V2::CampsController < Api::BaseController
	
	def index
      @camps = Camp.where(camp_status: 'Active')
      render json: @camps
    end

end
