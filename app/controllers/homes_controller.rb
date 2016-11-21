class HomesController < ApplicationController

  def index
    @homes = Home.all
    if params[:tags]
      @homes = Home.tagged(params[:tags])
    else
      @homes = Home.all.limit(10)
    end    
  end

  def create
    @home = Home.new(home_params)

    @home.save
    redirect_to action: :index
  end

  def show
    @home = Home.find(params[:id])
  end

  private
  def home_params
    params.require(home).permit(:address, :rating)
  end
  
end