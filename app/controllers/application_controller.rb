class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception, :with => :error_render_method

  def error_render_method
    redirect_to('/500.html') and return
  end

end
