class Profile < ActiveRecord::Base

  attr_accessible :age, :country, :defeats, :ratio, :score, :user_id, :victories, :avatar

  belongs_to :user, touch: true

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

    self.increment!(:defeats)
  end

  def draw
    self.increment_score(1)
    self.save
  end

  def prepare_games_list
    Games.joins(:matches).where(:matches => {:played_1_id => self.user.id, :player_2_id.self.user.id}).uniq_by(&:game_id)
  end

  def ratio_calc   
    self.defeats.blank? &&  self.victories.blank? ? 0 : (self.victories.to_f / (self.defeats.to_f + self.victories.to_f)).to_f
  end

end

