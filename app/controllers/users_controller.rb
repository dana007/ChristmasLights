class UsersController < ApplicationController
  def index

  end

  def new
  end

  def create
    new_user = User.new
    new_user.username = params[:user_name]
    new_user.password = params[:password]

    new_user.save
    $user = new_user
    redirect_to root_path
  end

  def login
    user_name = params[:user_name]
    user = User.find_by_username(user_name)
    if user != nil
      if user.password != params[:password]
        $error_message = 'Invalid username/password. Please try again.'
        redirect_to users_path
      else
        $user = user
        redirect_to root_path
      end
    else
      print("OMGOMGOMGOMGOMG")
      $error_message = 'Invalid username/password. Please try again.'
      redirect_to users_path
    end
  end

  def logout
    $user = nil
    redirect_to root_path
  end

  def show
    # @users = User.find(params[:id])
  end
end
