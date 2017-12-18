class BicyclesController < ApplicationController
  before_action :set_bicycle, only: [:show, :edit, :update, :destroy, :image]
  before_action :authenticate_user!

  # GET /bicycles
  # GET /bicycles.json
  def index
    @bicycles = current_user.bicycles
  end

  # GET /bicycles/1
  # GET /bicycles/1.json
  def show
  end

  # GET /bicycles/new
  def new
    @bicycle = current_user.bicycles.new
  end

  # GET /bicycles/1/edit
  def edit
  end

  # POST /bicycles
  # POST /bicycles.json
  def create
    @bicycle = current_user.bicycles.new(bicycle_params)

    respond_to do |format|
      if @bicycle.save
        format.html { redirect_to @bicycle, notice: 'Bicycle was successfully created.' }
        format.json { render :show, status: :created, location: @bicycle }
      else
        format.html { render :new }
        format.json { render json: @bicycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bicycles/1
  # PATCH/PUT /bicycles/1.json
  def update
    respond_to do |format|
      if @bicycle.update(bicycle_params)
        format.html { redirect_to @bicycle, notice: 'Bicycle was successfully updated.' }
        format.json { render :show, status: :ok, location: @bicycle }
      else
        format.html { render :edit }
        format.json { render json: @bicycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bicycles/1
  # DELETE /bicycles/1.json
  def destroy
    @bicycle.destroy
    respond_to do |format|
      format.html { redirect_to bicycles_url, notice: 'Bicycle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def image
    send_file @bicycle.image.path, type: @bicycle.image.content_type, disposition: 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bicycle
      @bicycle = current_user.bicycles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bicycle_params
      params.require(:bicycle).permit(:serial, :name, :image)
    end
end
