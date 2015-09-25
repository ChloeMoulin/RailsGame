class Admin::SearchController < Admin::AdminController
  def index
  end

  def research
    @users = User.get_user_like(params[:text])
    @games = Game.get_game_like(params[:text])
    @tournaments = Tournament.get_tournament_like(params[:text])
    respond_to do |format|
      format.js
    end
  end
end

