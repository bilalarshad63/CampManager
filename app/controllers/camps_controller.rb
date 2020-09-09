class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy,:toggle_status]
  layout 'admin_layout'

  def show
  end

  def new
    @camp = Camp.new
  end

  def toggle_status
    @camp.camp_status == 1 ? (@camp.camp_status = 0) :  (@camp.camp_status = 1)       
    if @camp.save
      redirect_to homepage_camps_path
    end
  end

  def edit
  end

  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to homepage_camps_path, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to homepage_camps_path, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camp_params
      params.require(:camp).permit(:camp_title, :camp_type,:camp_status, :applicant_registration_start_date, :applicant_registration_end_date, :applicant_registration_start_time, :applicant_registration_end_time, :parent_application_start_date, :parent_application_end_date, :parent_application_start_time, :parent_application_end_time)
    end
end
