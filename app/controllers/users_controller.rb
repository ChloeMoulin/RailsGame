class UsersController < Devise::SessionsController
  load_and_authorize_resource

  def new
    super
  end

  def show
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

end
