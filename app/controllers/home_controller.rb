class HomeController < ApplicationController

  # def index
  #   @homes = Home.search(params[:search])
  # end
  
  def index
    @homes = Home.all
    if params[:search]
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
     # @homes = Home.search(params[:search]).order('created_at_DESC')
      @homes = Home.search(params[:search])
    else
      #find(:all)
     # @homes = Home.all.order('created_at_DESC')
      @homes = Home.all
    end    
  end

end