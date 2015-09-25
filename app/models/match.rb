class Match < ActiveRecord::Base

  attr_accessible :player_1_score, :player_2_score
  after_commit :calc_points_for_players, :send_mail_score_match


  belongs_to :player_1, :class_name => 'User'
  belongs_to :player_2, :class_name => 'User'
  belongs_to :game
  belongs_to :tournament

  validates :player_1_score,  :allow_nil => true,
                              :numericality =>  { only_integer: true, greater_than: -1 }
  validates :player_2_score,  :allow_nil => true,
                              :numericality =>  { only_integer: true, greater_than: -1 }

  def calc_points_for_players

    profile_1 = self.player_1.profile
    profile_2 = self.player_2.profile

    if self.player_1_score > self.player_2_score

      self.player_1_points = 3
      self.player_2_points = 0

      profile_1.win
      profile_2.loose

    elsif self.player_2_score > self.player_1_score

      self.player_1_score = 0
      self.player_2_score = 3

      profile_1.loose
      profile_2.win
        

    else
      self.player_1_points = 1
      self.player_2_points = 1

      profile_1.draw
      profile_2.draw

    end
    profile_1.update_attributes(:ratio => profile_1.calc_ratio)
    profile_2.update_attributes(:ratio => profile_2.calc_ratio)
  end

  def uninscription_available?(user)
    if self.tournament.date < Date.today || (self.player_1 != user && self.player_2 != user)
      return false
    elsif self.player_1_score != nil && player_2_score != nil
      return false
    end
    return true
  end

  def unregister(user)
    if self.player_1 == user
      self.player_1 = nil
      user.played_1.reject! {|match| match.id == self.id}
    elsif self.player_2 == user
      self.player_2 = nil
      user.played_2.reject! {|match| match.id == self.id}
    end
    self.save
    user.save
  end

  def match_available?(user)

    if self.player_1 == nil && self.player_2 != user
      self.player_1 = user
      user.played_1 << self
      self.save
      Notifier.match_opponent(self.player_2,user,self.game,self.tournament).deliver
      Notifier.match_opponent(user,self.player_2,self.game,self.tournament).deliver
      return true      

    elsif self.player_2 == nil && self.player_1 != user
      self.player_2 = user
      user.played_2 << self
      self.save
      Notifier.match_opponent(self.player_1,user,self.game,self.tournament).deliver
      Notifier.match_opponent(user,self.player_1,self.game,self.tournament).deliver
      return true
    end     
  end

  def self.create_new_match(tournament,user,game)
    match = Match.new 
    match.game = game
    match.tournament = tournament
    match.player_1 = user
    user.played_1 << match
    if match.save
      return true
    else
      return false
    end
  end

  def send_mail_score_match
    Notifier.match_score(self.player_1,self.player_2,self.game,self.tournament,self).deliver
    Notifier.match_score(self.player_2,self.player_1,self.game,self.tournament,self).deliver
  end


end
