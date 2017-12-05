class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions
  # POST /positions.json
  def create
    #raw_lat = params[:latitude].to_s
    #raw_lon = params[:longitude].to_s
    #latitude = raw_lat[0,2].to_f + (raw_lat[2,raw_lat.length-2].to_f / 60.0)
    #longitude = raw_lon[0,3].to_f + (raw_lon[3,raw_lon.length-2].to_f / 60.0)

    payload = params[:payload]
    if payload.has_key?(:channels)
      postdata = payload[:channels]    
      latitude = postdata[0][:value]
      longitude = postdata[1][:value]
      press_zero = postdata[2][:value]
      press_one = postdata[3][:value]
      press_two = postdata[4][:value]
      press_three = postdata[5][:value]
      accel_x = postdata[6][:value]
      accel_y = postdata[7][:value]
      accel_z = postdata[8][:value]

      data = {serial: params[:module], latitude: latitude, longitude: longitude, press_zero: press_zero, press_one: press_one, press_two: press_two, press_three: press_three, accel_x: accel_x, accel_y: accel_y, accel_z: accel_z}

      @position = Position.new(data)
    else
      render :nothing => true, :status => 200
    end

    respond_to do |format|
      if @position.save
        ActionCable.server.broadcast 'bycycle_channel', message: @position.to_json.to_s
        format.html { redirect_to @position, notice: 'Position was successfully created.' }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @position, notice: 'Position was successfully updated.' }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to positions_url, notice: 'Position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def position_params
      params.require(:position).permit(:serial, :latitude, :longitude, :press_zero, :press_one, :press_two, :press_three, :accel_x, :accel_y, :accel_z)
    end
end
