class Match < ActiveRecord::Base

  attr_accessible :player_1_score, :player_2_score
  after_commit :calc_points_for_players


  belongs_to :player_1, :class_name => 'User'
  belongs_to :player_2, :class_name => 'User'
  belongs_to :game
  belongs_to :tournament

  validates :player_1_score, :numericality =>  { only_integer: true, greater_than: -1 }
  validates :player_2_score, :numericality =>  { only_integer: true, greater_than: -1 }

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

  def match_available?(user)

    if self.player_1 == nil && self.player_2 != user
      self.player_1 = user
      user.played_1 << self
      self.save
      return true      

    elsif self.player_2 == nil && self.player_1 != user
      self.player_2 = user
      user.played_2 << self
      self.save
      return true
    end     
  end

  def self.create_new_match(tournament,user,game)
    match = Match.new 
    match.game = game
    match.tournament = tournament
    match.player_1 = user
    user.matches << match
  end
end
