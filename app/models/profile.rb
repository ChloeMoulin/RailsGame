class Profile < ActiveRecord::Base

  attr_accessible :age, :country, :defeats, :ratio, :score, :user_id, :victories, :avatar

  belongs_to :user

  before_save :ratio_calc

  mount_uploader :avatar, CoverUploader

  def increment_victories
    self.victories = (self.victories || 0) + 1
  end

  def increment_defeats
    self.defeats = (self.defeats || 0) + 1
  end

  def increment_score(n)
    self.score = (self.score || 0) + n
  end

  def win
    self.increment_victories
    self.increment_score(3)
    self.save
  end

  def loose
    self.increment_defeats
    self.save
  end

  def draw
    self.increment_score(1)
    self.save
  end

  def prepare_games_list
    user = self.user
    tourmanents = user.tournaments
    games = Array.new

     user.played_1.each do |match|
      games << match.game
    end
    user.played_2.each do |match|
      games << match.game
    end

    return games.uniq!
  end

  def ratio_calc   
    ratio = 0
    if self.defeats.blank? &&  self.victories.blank?
      ratio = 0
    else
      ratio = (self.victories.to_f / (self.defeats.to_f + self.victories.to_f)).to_f
    end
  end

end
