class ApplicationController < ActionController::Base
  protect_from_forgery


  protected

    def current_user 
      return unless session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end

  helper_method :current_user


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
  
end
