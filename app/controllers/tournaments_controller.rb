class TournamentsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def index
    @tournaments = Tournament.order_for_index
    respond_with(@tournaments)
  end

  def show
    @tournament = Tournament.find(params[:id])
    @users_and_victories = User.build_ranking(@tournament)
    respond_with(@tournament)
  end

  def new 
    @tournament = Tournament.new
    @games = Game.all
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @games = Game.all
    if @tournament.save
      redirect_to tournaments_path, :notice => 'Tournament successfully created'
    else
      render :action => 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
    @games = Game.all
  end

  def update
    @tournament = Tournament.find(params[:id])
    @games = Game.all
    if @tournament.update_attributes(params[:tournament])
      redirect_to tournaments_path, :notice => 'Updated tournament information successfully'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    respond_with(@tournament)
  end

  def register
    authorize! :register, @tournament if params[:user][:register]
    @tournament = Tournament.find(params[:id])
    @user = current_user

    msg = @tournament.register_for_tournament(@user)  

    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament, :notice => msg
    else
      render :action => 'show'
    end
  end

  def register_match
    authorize! :register_match, Tournament
    @tournament = Tournament.find(params[:id])
    @game = Game.find(params[:game_id])
    @user = current_user

    @tournament.find_a_match(@game, @user)
    redirect_to @tournament, :notice => "You've been added to a match !"
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  private
    def tournaments_params
      params.require(:tournament).permit(:name, :description, :date, :place, :max_player, :game_ids => [], :user_ids => [])
    end

end
