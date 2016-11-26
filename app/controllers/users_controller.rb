class UsersController < ApplicationController
  def index
    # @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    # @users = User.new(user_params)
    #
    # @users.save
    # redirect_to action: :index
  end

  def login

  end

  def show
    # @users = User.find(params[:id])
  end
end
