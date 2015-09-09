class TournamentsController < ApplicationController

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
