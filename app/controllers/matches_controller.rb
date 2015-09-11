class MatchesController < ApplicationController

	after_filter :calc_points, :only => [:update]
	respond_to :html
	def edit
		@match = Match.find(params[:id])
	end

	def update
		@match = Match.find(params[:id])
    	if @match.update_attributes(params[:match])
    		respond_with(@match.tournament)
    	end
  	end

  	def calc_points
  		@match = Match.find(params[:id])

  		p1_d = 0
  		p1_v = 0
  		p1_s = 0
  		p2_d = 0
  		p2_v = 0
  		p2_s = 0

  		if @match.player_1_score > @match.player_2_score
  			@match.player_1_points = 3
  			@match.player_2_points = 0

  			p1_v = 1
  			p2_d = 1
  			p1_s = 3

  		elsif @match.player_2_score > @match.player_1_score
  			@match.player_1_score = 0
  			@match.player_2_score = 3

  			p2_v = 1
  			p2_s = 3
  			p1_d = 1
  		elsif @match.player_2_score == @match.player_1_score
  			@match.player_1_points = 1
  			@match.player_2_points = 1

  			p1_s = 1
  			p2_s = 1

  		end

  		if @match.player_1.profile.victories != nil
  			p1_v += @match.player_1.profile.victories
  		end

  		if @match.player_1.profile.defeats != nil
  			p1_d += @match.player_1.profile.defeats
  		end

  		if @match.player_1.profile.score != nil
  			p1_s += @match.player_1.profile.score
  		end

  		if @match.player_2.profile.victories != nil
  			p2_v += @match.player_2.profile.victories
  		end

  		if @match.player_2.profile.defeats != nil
  			p2_d += @match.player_2.profile.defeats
  		end

  		if @match.player_2.profile.score != nil
  			p2_s += @match.player_2.profile.score

  		end

  		@match.player_1.profile.update_attributes(:victories => p1_v, :defeats => p1_d, :score => p1_s)
  		@match.player_2.profile.update_attributes(:victories => p2_v, :defeats => p2_d, :score => p2_s)
  	end
end
