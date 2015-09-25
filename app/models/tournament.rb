class Tournament < ActiveRecord::Base
  
  attr_accessible :date, :max_player, :name, :description, :game_ids, :user_ids, :address, :latitude, :longitude

  has_and_belongs_to_many :games
  has_and_belongs_to_many :users
  has_many :matches

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  validates :name, :presence => true,
            :format => {:with => /^[a-zA-Z0-9_ éèà]{5,20}$/i},
            :length => {:within => 5..20}

  validates :description, :presence => true,
                          :format => {:with => /^[a-zA-Z0-9 ]{10,200}$/i},
                          :length => {:within => 10..200} 

  validates :date,  :presence => true
                    #:format => {:with => /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/i}

  validate :date_cannot_be_in_the_past

  validates :max_player,  :presence => true,
                          :numericality =>  { only_integer: true, greater_than: 4 }

  validates_presence_of :games


  def find_a_match(game, user)

    self.matches.each do |match|
      if match.game == game
        if match.match_available?(user) == true
          return true
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
    Notifier.inscription_tournament(self,user).deliver
    return msg
  end


  def date_cannot_be_in_the_past
    errors.add(:date, "Date must be higher or equal to today") if !date.blank? && date < Date.today
  end


  def self.get_tournament_like(text)
    sql = "Select id, name, description, address from tournaments where (name like '%#{text}%' or description like '%#{text}%' or address like '%#{text}%')"
    return ActiveRecord::Base.connection.exec_query(sql).rows
  end

end
