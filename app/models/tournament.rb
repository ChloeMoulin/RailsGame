class Tournament < ActiveRecord::Base

  attr_accessible :place, :date, :max_player, :name, :description, :game_ids, :user_ids

  has_and_belongs_to_many :games
  has_and_belongs_to_many :users
  has_many :matches

  validates :name, :presence => true
  validates :description, :presence => true
  validates :place, :presence => true
  validates :date, :presence => true
  validates :max_player, :presence => true
  validates_presence_of :games

  def find_a_match(game, user)

    self.matches.each do |match|
      if match.game == game
        if match.match_available?(user) == true
          return
        end
      end
    end
    Match.create_new_match(self,user,game)
  end

  def can_register?
    self.date < Date.today || self.max_player <= self.users.count
  end

  def self.order_for_index
    tournaments = Tournament.order("date desc")
    tournaments_can_register = Array.new
    tournaments_cannot_register = Array.new
    tournaments.each{|tournament| tournament.can_register? ? tournaments_cannot_register << tournament : tournaments_can_register << tournament}
    return (tournaments_can_register << tournaments_cannot_register).flatten!
  end

  def register_for_tournament(user)
    msg =""

    if (user.tournaments.include?(self))
      msg = "You've already registered for this tournament !"
    else
      msg = "You've successfully registered for this tournament !"
      self.users << user
    end

    return msg
  end

end
