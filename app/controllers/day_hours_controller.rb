class DayHoursController < ApplicationController
  before_action :set_day_hour, only: [:show, :edit, :update, :destroy]

  # GET /day_hours
  # GET /day_hours.json
  def index
    @day_hours = DayHour.all
  end

  # GET /day_hours/1
  # GET /day_hours/1.json
  def show
  end

  # GET /day_hours/new
  def new
    @day_hour = DayHour.new
  end

  # GET /day_hours/1/edit
  def edit
  end

  # POST /day_hours
  # POST /day_hours.json
  def create
    @day_hour = DayHour.new(day_hour_params)
    respond_to do |format|
      if @day_hour.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @day_hour }
      else
        format.html { render :new }
        format.json { render json: @day_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day_hours/1
  # PATCH/PUT /day_hours/1.json
  def update
    respond_to do |format|
      if @day_hour.update(day_hour_params)
        format.html { redirect_to @day_hour, notice: 'Day hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @day_hour }
      else
        format.html { render :edit }
        format.json { render json: @day_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_hours/1
  # DELETE /day_hours/1.json
  def destroy
    @day_hour.destroy
    respond_to do |format|
      format.html { redirect_to day_hours_url, notice: 'Day hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_all
    Venue.find_by(name: 'New Place').day_hours.all.each do |day_hour|
      day_hour.destroy
    end
    redirect_to root_url, notice: 'New Place successfully restarted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_hour
      @day_hour = DayHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_hour_params
      day_hour_params = params.require(:day_hour).permit(:venue_id, :opening_time, :closing_time, :day)
      day_hour_params[:opening_time].sub!(/\..*/,'')
      day_hour_params[:closing_time].sub!(/\..*/,'')
      day_hour_params[:day].downcase!
      day_hour_params
    end
end
