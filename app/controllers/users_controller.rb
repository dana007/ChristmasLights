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
    cookies[:user_id] = new_user.id
    $info_message = 'Account creation successful.'
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
        cookies[:user_id] = user.id
        redirect_to root_path
      end
    else
      $error_message = 'Invalid username/password. Please try again.'
      redirect_to users_path
    end
  end

  def logout
    cookies.delete :user_id
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.password = params[:password]
    user.save
    $info_message = 'Password update successful.'
    redirect_to user_path(user.id)
  end
end
