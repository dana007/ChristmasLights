class HomeController < ApplicationController

  def index
    render json: {status: "Christmas Lights app is running..."}
  end

end