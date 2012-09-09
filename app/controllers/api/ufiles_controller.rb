class Api::UfilesController < Api::ApplicationController
  def index
    @ufiles = Ufile.where(:location_id => params[:location_id]).order("id DESC").all
    logger.info @ufiles.map{|x| x.to_jq_upload }.to_json
    respond_with(@ufiles.map{|x| x.to_jq_upload }.to_json)
  end
  
  def show
    respond_with(Ufile.find(params[:id]))
  end

  def create
    @ufile = Ufile.new params[:ufile]
    if @ufile.save
      render json: [@ufile.to_jq_upload].to_json
    else
      respond_with(@ufile, status: :unprocessable_entity)
    end
  end

  def update
    @ufile = Ufile.find(params[:id])

    respond_to do |format|
      if @ufile.update_attributes(params[:ufile])
        format.html { redirect_to @ufile, notice: 'Ufile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ufile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ufile = Ufile.find(params[:id])
    @ufile.destroy
    respond_with(:no_content)
  end
end
