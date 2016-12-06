class UsersController < ApplicationController
  def index

  end

  def new
  end

  def create
    if User.exists?(username: params[:user_name])
      $error_message = 'A user with that username already exists!'
      redirect_to(new_user_path) and return
    end

    new_user = User.new
    new_user.username = params[:user_name]
    new_user.email = params[:email]
    new_user.password = params[:password]

    new_user.save
    cookies[:user_id] = new_user.id
    $info_message = 'Account created successfully.'
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
    $info_message = 'You have logged out successfully.'
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if not params[:password].empty?
      user.password = params[:password]
      user.save
      $info_message = 'Password updated successfully.'
    end
    if not params[:email].empty?
      user.email = params[:email]
      user.save
      $info_message = 'Email updated successfully.'
    end
    redirect_to user_path(user.id)
  end

  def send_reset_password_email
    email = params[:email]
    username = params[:user_name]
    if User.exists?(email: email, username: username)
      user = User.find_by_username(username)
      UserMailer.password_reset_email(email, user.id).deliver
      $info_message = "Password email successfully sent to #{email}"
      redirect_to reset_password_users_path
    else
      $error_message = "No user found with the username #{username} and email #{email}"
      redirect_to reset_password_users_path
    end
  end

  def reset_password

  end

  def update_password
    @user = User.new
  end

  def change_password
    user = User.find(params[:id])
    user.password = params[:password]
    user.save
    $info_message = 'Password updated successfully.'

    redirect_to users_path
  end
end
