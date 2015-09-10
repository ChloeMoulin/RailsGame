class TournamentsController < ApplicationController


	respond_to :html

	def index
		@tournaments = Tournament.all
   		 respond_with(@tournaments)
  	end

	def show
		@tournament = Tournament.find(params[:id])
   		 respond_with(@tournament)
	end

	def new 
		@tournament = Tournament.new
		@games = Game.all
	end

	def create
		@tournament = Tournament.new(params[:tournament])
		@games = Game.all
		if @tournament.save
			redirect_to tournaments_path, :notice => 'Tournament successfully created'
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
			redirect_to tournaments_path, :notice => 'Updated tournament information successfully'
		else
			render :action => 'edit'
		end
	end

	def tournaments_params
      params.require(:tournament).permit(:name, :description, :date, :place, :max_player, :game_ids => [], :user_ids => [])
    end

	def destroy
		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		respond_with(@tournament)
 	end

 	def register
 		@tournament = Tournament.find(params[:id])
 		@user = current_user
 		if (@user.tournaments.include?(@tournament) && @tournament.users.include?(@user))
 			redirect_to @tournament, :notice => "You already have registered for this tournament !"
 		else
			@user.tournaments << @tournament
			if @tournament.update_attributes(params[:tournament]) && @user.update_attributes(params[:user])
				redirect_to @tournament, :notice => "You've been successfully registered for this tournament"
			else
				render :action => 'show'
			end
		end
 	end

 	def register_match
 		@tournament = Tournament.find(params[:id])
 		@game = Game.find(params[:game_id])
 		@user = current_user
 		bool = false

 		@tournament.matches.each do |match|
 			if match.game = @game && (match.player_1 = nil && player_2 != @user)
 				match.player_1 = @user
 				@user.matches << match
 				match.save
 				bool = true
 				break
 			elsif match.game = @game && (match.player_2 = nil && player_1 != @user)
 				match.player_2 = @user
 				@user.matches << match
 				match.save
 				bool = true
 				break
 			end
 		end
 		if !bool
 			@match = Match.new
 			@match.player_1 = @user
 			@user.matches << @match
 			@tournament.matches << @match
 			@tournament.save
 			@game.matches << @match
 			@game.save
 		end

 		@user.save
 		redirect_to @tournament, :notice => "You've been added to a match !"
 	end

end
