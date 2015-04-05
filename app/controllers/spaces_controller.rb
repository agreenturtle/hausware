class SpacesController < ApplicationController
  before_action :set_location
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = @location.spaces.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = @location.spaces.build
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = @location.spaces.build(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, notice: 'Space was successfully created.' }
        format.json { render :show, status: :created, location: [@space.location, @space] }
      else
        format.html { render :new }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to [@space.location, @space], notice: 'Space was successfully updated.' }
        format.json { render :show, status: :ok, location: [@space.location, @space] }
      else
        format.html { render :edit }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to location_spaces_url(@location), notice: 'Space was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find_by_permalink(params[:location_id])
      raise ActiveRecord::RecordNotFound unless @location
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = @location.spaces.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound unless @space
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name, :permalink, :standard_hourly_price_in_cents, :picurl, :reservable_quantity, :description)
    end
end