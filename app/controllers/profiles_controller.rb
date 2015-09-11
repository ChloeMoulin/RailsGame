class ProfilesController < ApplicationController

	before_filter :ratio_calc, only: [:show]
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :load_user, :only => [:edit, :update, :show]

	def create
		@profile =  Profile.users.new(params[:profile])
		if @profile.save
			redirect_to @profile, :notice => 'Votre profil a bien été créé.'
		else
			
		end
	end

	def show
		@profile = @user.profile
		@tournaments = @user.tournaments
		@games = Array.new
		@user.played_1.each do |match|
			@games << match.game
		end
		@user.played_2.each do |match|
			@games << match.game
		end
		@games.uniq!
	end

	def update
		@profile = @user.profile
		if @profile.update_attributes(params[:profile])
			redirect_to @profile, :notice => 'Updated your profile information successfully.'
		else
		end
	end

	def edit
		@profile = @user.profile
	end

	private
		def load_user
			@user = current_user
		end

		def ratio_calc
			@profile = current_user.profile
			ratio = 0
			if @profile.defeats.blank? &&  @profile.victories.blank?
				ratio = 0
			else
				ratio = (@profile.victories.to_f / (@profile.defeats.to_f + @profile.victories.to_f)).to_i
			end
			@profile.update_attributes(:ratio => ratio)


		def games_params
      		params.require(:profile).permit(:avatar)
    	end

	end
end
