class ApplicationController < ActionController::Base
  protect_from_forgery


  protected

  def authenticate 
    user_signed_in? ? true : access_denied
  end

  def access_denied
    redirect_to login_path, :notice => "Please log in to continue" and return false
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username,:email,:profile, :password) }
  end
  
end
