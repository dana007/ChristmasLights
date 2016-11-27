class HomesController < ApplicationController

   def index

   @filterrific = initialize_filterrific(
      Home,
      params[:filterrific],
      select_options: {
        sorted_by: Home.options_for_sorted_by,
          with_state: Home.state_options_for_select,
          with_city: Home.city_options_for_select,
          with_rating: Home.rating_options_for_select
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [],
    ) or return

    @homes = @filterrific.find.page(params[:page])
        respond_to do |format|
        format.html
        format.js
      end

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def create
  end

  def show
    #Rails.logger.debug("Dana XXX We are here")
    #console.log ("Dana: id: " +  params[:id])
    @home = Home.find(params[:id])
    #debugger
    #@home = Home.new(id: 1, title: 'test 2',address: 'Fairfax', rating: 4 )
    #@home = Home.new
    # @home.rating = 4
  end

  def user_homes
    user_id = cookies[:user_id]

    @filterrific = initialize_filterrific(
      Home,
      params[:filterrific],
      select_options: {
          sorted_by: Home.options_for_sorted_by,
          with_user_id: user_id,
          with_city: Home.city_options_for_select
      },
      persistence_id: 'shared_key'
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
