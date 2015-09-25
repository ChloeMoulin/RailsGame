class Game < ActiveRecord::Base

  attr_accessible :company, :description, :grade, :name, :platform, :released_at, :cover_filename, :cover

  has_and_belongs_to_many :tournaments
  has_many :matches

  validates :name,  :presence => true,
                    :format => {:with => /^[a-zA-Z0-9_ :]{5,20}$/i},
                    :length => {:within => 1..20}

  validates :description, :presence => true,
                          :format => {:with => /^[a-zA-Z0-9 ():éèà]{10,200}$/i},
                          :length => {:within => 10..200}

  validates :company, :presence => true,
                      :format => {:with => /^[a-zA-Z0-9_ ]{5,20}$/i},
                      :length => {:within => 1..20}

  validates :grade, :presence => true,
                    :numericality =>  { only_integer: true}

  validates :platform,  :presence => true, 
                        :format => {:with => /^[a-zA-Z0-9 ]{3,20}$/i}

  validates :released_at, :presence => true,
                          :format => {:with => /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/i}


  mount_uploader :cover, CoverUploader 

  def set_grade(value)
    value == "up" ? self.increment!(:grade) : self.decrement!(:grade)
    puts self.errors.full_messages
  end

  def self.most_played_games
    # sql = "Select g.name, count(m.id) from games g left outer join matches m on m.game_id = g.id group by g.id order by count(m.id) desc"
    # return ActiveRecord::Base.connection.exec_query(sql).rows
    Game.joins(:matches).select("games.name, count(*) as total_matches").group("games.name")
  end

  def self.best_grade_games
    # sql = "Select name, grade from games order by grade desc"
    # return ActiveRecord::Base.connection.exec_query(sql).rows
    Game.order("grade desc")
  end

  def self.best_players_by_game
    sql = "select distinct name,username, count(matches.id) from users inner join matches on (users.id = matches.player_1_id or users.id = matches.player_2_id) inner join games on games.id = matches.game_id where (users.id = matches.player_1_id and player_1_score > player_2_score) or (users.id = matches.player_2_id and matches.player_2_score > matches.player_1_score) group by name, username order by count(matches.id) desc"
    result = ActiveRecord::Base.connection.exec_query(sql).rows
    result = result.map{|a,b,c| [a, {b => c}.to_hash]}
    result = Hash[
      result.group_by(&:first).collect do |key, values|
        [ key, values.collect { |v| v[1] } ]
      end
    ]
    return result
  end

  def self.get_game_like(text)
    sql = "Select id, name, description, company, platform from games where (name like '%#{text}%' or description like '%#{text}%' or platform like '%#{text}%' or company like '%#{text}%' )"
    return ActiveRecord::Base.connection.exec_query(sql).rows
  end

end
  