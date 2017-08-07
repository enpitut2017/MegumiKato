class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  def getpos
    positions = Position.last(10)
    render :json => positions.to_json
    #render :json => {latitude: rand(36.04...36.08), longitude: rand(140.03...140.05)}
  end

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
    raw_lat = params[:latitude].to_s
    raw_lon = params[:longitude].to_s
    latitude = raw_lat[0,2].to_f + (raw_lat[2,raw_lat.length-2].to_f / 60.0)
    longitude = raw_lon[0,3].to_f + (raw_lon[3,raw_lon.length-2].to_f / 60.0)
    data = data = {serial: params[:serial],latitude: latitude, longitude: longitude} 

    @position = Position.new(data)

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
      params.require(:position).permit(:serial, :latitude, :longitude)
    end
end
