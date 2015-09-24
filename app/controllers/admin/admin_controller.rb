class Admin::AdminController < ApplicationController

  before_filter :verify_admin
  
  private
    def verify_admin
      redirect_to root_url unless (user_signed_in? && current_user.role == "admin")
    end
end
