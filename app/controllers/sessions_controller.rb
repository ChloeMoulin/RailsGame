class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"]) 
      redirect_to root_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end
end