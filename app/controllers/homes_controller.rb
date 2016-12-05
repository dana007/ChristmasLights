class HomesController < ApplicationController

  def index
    @action = 'index'

    @per_page_options = [[10, 10], [25, 25], [50, 50], [100, 100]]
    @selected_per_page = 10

    if params.has_key?(:per_page)
      @selected_per_page = params[:per_page]
      params[:filterrific][:per_page] = @selected_per_page
    end

    Home.set_per_page(@selected_per_page)

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
             sorted_by: 'created_at_desc'
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

  def new
    @home = Home.new
  end

  def create
    new_params = home_params.merge({user_id: cookies[:user_id]})
    @home = Home.create(new_params)
    $info_message = 'Home added successfully.'
    redirect_to home_path(@home.id)
  end

  def show
    @comment = Comment.new
    @home = Home.find(params[:id])
    @is_favorited = Favorite.where(user_id: cookies[:user_id]).where(home_id: @home.id).first.nil? ? false : true
  end

  def update_rating
    home = Home.find(params[:id])
    home.rating += Integer(params[:rating])
    home.save

    redirect_to home_path(home.id)
  end

  def update_favorites
    update_type = params[:update_type]

    if update_type == 'delete'
      favorite = Favorite.where(user_id: cookies[:user_id]).where(home_id: params[:id]).first
      favorite.destroy
    else
      Favorite.create(user_id: cookies[:user_id], home_id: params[:id])
    end

    redirect_to home_path(params[:id])
  end

  def user_homes
    @action = 'user_homes'

    @per_page_options = [[10, 10], [25, 25], [50, 50], [100, 100]]
    @selected_per_page = 10

    if not params[:per_page].nil?
      @selected_per_page = params[:per_page]
    end

    Home.set_per_page(@selected_per_page)

    user_id = cookies[:user_id]

    @filterrific = initialize_filterrific(
      Home,
      params[:filterrific],
      select_options: {
          sorted_by: Home.options_for_sorted_by,
          with_city: Home.city_options_for_select_user(user_id),
          with_state: Home.state_options_for_select_user(user_id),
          with_neighborhood: Home.neighborhood_options_for_select_user(user_id)
      },
      default_filter_params: {
          with_user_id: user_id,
          sorted_by: 'created_at_desc'
      },
      persistence_id: false
    ) or return

    @homes = @filterrific.find.page(params[:page]).where(user_id: user_id)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def favorite_homes
    all_favorites = Favorite.where(user_id: cookies[:user_id])
    favorite_home_ids = all_favorites.map{|fav| fav.home_id}

    @action = 'favorite_homes'

    @per_page_options = [[10, 10], [25, 25], [50, 50], [100, 100]]
    @selected_per_page = 10

    if not params[:per_page].nil?
      @selected_per_page = params[:per_page]
    end

    Home.set_per_page(@selected_per_page)

    @filterrific = initialize_filterrific(
        Home,
        params[:filterrific],
        select_options: {
            sorted_by: Home.options_for_sorted_by,
            with_city: Home.city_options_for_select_homes(favorite_home_ids),
            with_state: Home.state_options_for_select_homes(favorite_home_ids),
            with_neighborhood: Home.neighborhood_options_for_select_homes(favorite_home_ids)
        },
        default_filter_params: {
            with_home_id: favorite_home_ids,
            sorted_by: 'created_at_desc'
        },
        persistence_id: false
    ) or return

    @homes = @filterrific.find.page(params[:page]).where(id: favorite_home_ids)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def add_comment
    @comment = Comment.new(comment_params)
    if @comment.save
      $info_message = 'Your comment posted successfully!'
      redirect_to :back
    else
      $error_message = 'An unexpected error occurred. Your comment was not posted.'
      redirect_to :back
    end
  end

  private
  def home_params
    params.require(:home).permit(:title, :description, :street_address, :city, :state, :zip_code, :neighborhood, :image)
  end

  def comment_params
    params.require(:comment).permit(:user_id, :home_id, :content)
  end

end
