class Admin::SearchController < Admin::AdminController
  def index
  end

  def research
    @users = User.get_user_like(params[:text]).paginate(:page => params[:users_page], :per_page => 5)
    @games = Game.get_game_like(params[:text]).paginate(:page => params[:games_page], :per_page => 5)
    @tournaments = Tournament.get_tournament_like(params[:text]).paginate(:page => params[:tournaments_page], :per_page => 5)
    respond_to do |format|
      format.js
    end
  end
end

