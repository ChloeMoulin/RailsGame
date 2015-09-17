class MatchesController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      respond_with(@match.tournament)
    end
  end

  def unregister_match
    @match = Match.find(params[:id])
    @user = current_user
    @match.unregister(@user)
    redirect_to @match.tournament
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

end
