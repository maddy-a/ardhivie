class DownloadController < ApplicationController
  def ufile
    redirect_to Ufile.find(params[:id]).data.expiring_url(10)
  end
end