class Notifier < ActionMailer::Base
  default from: "c.moulin29@laposte.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.inscription.subject
  #
  def inscription(user)    
    @username = user.username
    @email = user.email
    @id = user.id
    mail to: user.email, :subject => "Welcome !"
  end

  def inscription_tournament(tournament,user)
    @username = user.username
    @tournament_name = tournament.name
    @tournament_date = tournament.date
    @tournament_place = tournament.address
    mail to: user.email, :subject => "Inscription au Tournois !"
  end

  def match_opponent(user,opponent,game, tournament)
    @username = user.username
    @opponent_name = opponent.username
    @tournament_name = tournament.name
    @game_name = game.name
    mail to: user.email, :subject => "Adversaire trouvé !"
  end

  def match_score(user,opponent, game, tournament, match)
    @username = user.username
    @opponent_name = opponent.username
    @tournament_name = tournament.name
    @game_name = game.name
    @player_1 = match.player_1.username
    @player_2 = match.player_2.username
    @score_1 = match.player_1_score
    @score_2 = match.player_2_score
    mail to: user.email, :subject => "Résultat d'un match !"
  end
end 
