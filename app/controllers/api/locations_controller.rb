class Api::LocationsController < Api::ApplicationController
  def index
    @locations = current_user.locations.all
    respond_with(@locations)
  end

  def show
    respond_with(Location.find(params[:id]))
  end

  def create
    @location = Location.new params[:location]
    @location.user = current_user
    if @location.save
      respond_with(@location)
    else
      respond_with(@location, status: :unprocessable_entity)
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
