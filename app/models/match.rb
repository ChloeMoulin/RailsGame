class Match < ActiveRecord::Base


	attr_accessible :player_1_score, :player_2_score
 	belongs_to :player_1, :class_name => 'User'
  belongs_to :player_2, :class_name => 'User'
	belongs_to :game
	belongs_to :tournament
end
