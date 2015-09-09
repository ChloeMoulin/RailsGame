class TournamentsController < ApplicationController


	respond_to :html

	def index
		@tournaments_and_games = Hash.new
		@tournaments = Tournament.all
		@tournaments.each do |tournament|
			@tournaments_and_games[tournament] = Array.new
			tournament.game_ids.each do |game_id|
				@tournaments_and_games[tournament] << Game.find_by_id(game_id).name
			end
		end

    respond_with(@tournaments)
  end

	def new 
		@tournament = Tournament.new
		@games = Game.all
	end

	def create
		@tournament = Tournament.new(params[:tournament])
		@games = Game.all
		if @tournament.save
			redirect_to games_path, :notice => 'Tournament successfully created'
		else
			render :action => 'new'
		end
	end

	def edit
		@tournament = Tournament.find(params[:id])
		@games = Game.all
	end

	def update
		@tournament = Tournament.find(params[:id])
		@games = Game.all
		if @tournament.update_attributes(params[:tournament])
			redirect_to games_path, :notice => 'Updated tournament information successfully'
		else
			render :action => 'edit'
		end
	end

	def tournaments_params
      params.require(:tournament).permit(:name, :description, :date, :place, :max_player, :game_ids => [])
    end
end
