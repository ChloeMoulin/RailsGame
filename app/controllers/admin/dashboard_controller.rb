class Admin::DashboardController < Admin::AdminController

  def index
    @most_played_games = Game.most_played_games
    @best_grade_games = Game.best_grade_games
    @best_players = Profile.best_players
    @best_players_by_game = Game.best_players_by_game
  end
 
end
