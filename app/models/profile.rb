class Profile < ActiveRecord::Base

  attr_accessible :date_of_birth, :country, :defeats, :ratio, :score, :user_id, :victories, :avatar

  belongs_to :user, touch: true

  mount_uploader :avatar, CoverUploader

  validates :date_of_birth,   :allow_nil => true,
                              :format => {:with => /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/i}

  validate :date_cannot_be_in_the_future

  validates :country, :allow_nil => true,
                      :format => {:with => /^[a-zA-Z -]{2,15}$/i}
                    

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
    Game.joins(:matches).where(:matches => {:player_1_id => self.user.id, :player_2_id => self.user.id}).uniq_by(&:game_id)
  end

  def calc_ratio 
    self.defeats.blank? &&  self.victories.blank? ? 0 : ((self.victories.to_f / (self.defeats.to_f + self.victories.to_f)).to_f).round(2)
  end

  def date_cannot_be_in_the_future
    errors.add(:date_of_birth, "You're not born yet !!") if !date_of_birth.blank? && date_of_birth > Date.today
  end

end

