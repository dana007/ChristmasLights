class HomesController < ApplicationController

   def index
     @filterrific = initialize_filterrific(
         Home,
         params[:filterrific],
         select_options: {
            sorted_by: Home.options_for_sorted_by,
            with_city: Home.city_options_for_select,
            with_state: Home.state_options_for_select,
            with_neighborhood: Home.neighborhood_options_for_select
         },
         persistence_id: false
     ) or return

     @homes = @filterrific.find.page(params[:page])

     respond_to do |format|
       format.html
       format.js
     end

   rescue ActiveRecord::RecordNotFound => e
     puts "Had to reset filterrific params: #{e.message}"
     redirect_to(reset_filterrific_url(format: :html)) and return
   end

  def create
  end

  def show
    
    @home = Home.find(params[:id])
   
  end

  def user_homes
    user_id = cookies[:user_id]

    @filterrific = initialize_filterrific(
      Home,
      params[:filterrific],
      select_options: {
          sorted_by: Home.options_for_sorted_by,
          with_city: Home.city_options_for_select,
          with_state: Home.state_options_for_select,
          with_neighborhood: Home.neighborhood_options_for_select
      },
      default_filter_params: {
          with_user_id: user_id
      },
      persistence_id: false
    ) or return

    @homes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  private
  def home_params
    params.require(home).permit(:title, :state, :city, :rating)
  end

end
