class Profile < ActiveRecord::Base

  attr_accessible :date_of_birth, :country, :defeats, :ratio, :score, :user_id, :victories, :avatar, :address, :latitude, :longitude
  attr_accessor :location_address

  belongs_to :user, touch: true

  mount_uploader :avatar, CoverUploader

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  validates :date_of_birth,   :allow_nil => true,
                              :format => {:with => /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/i}

  validate :date_cannot_be_in_the_future
                    

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
    Game.joins(:matches).where("matches.player_1_id = ? OR matches.player_2_id = ?", user.id, user.id).uniq_by(&:id)
  end

  def calc_ratio 
    self.defeats.blank? &&  self.victories.blank? ? 0 : ((self.victories.to_f / (self.defeats.to_f + self.victories.to_f)).to_f).round(2)
  end

  def date_cannot_be_in_the_future
    errors.add(:date_of_birth, "You're not born yet !!") if !date_of_birth.blank? && date_of_birth > Date.today
  end

  def self.best_players
    # sql = "Select username, score, victories, ratio from users inner join profiles on users.id = profiles.user_id order by score desc"
    # return ActiveRecord::Base.connection.exec_query(sql).rows
    #Profile.includes(:user).order(:score)
    Profile.joins(:user).select("users.username as username, score, ratio, victories").order("score desc")
  end


end

