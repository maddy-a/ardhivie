class Api::HomeController < Api::ApplicationController
  def index
    respond_with({:status => :ok})
  end
end
