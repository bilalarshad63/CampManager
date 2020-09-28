class Api::V1::CampsController < ApplicationController

	def index
      @camps = Camp.where(camp_status: 'Active')
      render json: @camps
    end

end
