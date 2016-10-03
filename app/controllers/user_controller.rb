class UserController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    @user.save
    redirect_to action: :index
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :birth_year)
  end
end
