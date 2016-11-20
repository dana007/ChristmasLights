class HomesController < ApplicationController

  # def index
  #   @homes = Home.search(params[:search])
  # end
  
  def index
    @homes = Home.all
    if params[:search]
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
     # @homes = Home.search(params[:search]).order('created_at_DESC')
      @homes = Home.search(params[:search]).all
    else
      #find(:all)
     # @homes = Home.all.order('created_at_DESC')
      @homes = Home.all
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