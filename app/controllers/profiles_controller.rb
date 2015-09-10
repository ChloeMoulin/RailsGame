class ProfilesController < ApplicationController

	before_filter :ratio_calc, only: [:create, :save]
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
		@user.matches do |match|
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
			if @profile.defeats.blank? &&  @profile.victories.blank?
				@profile.ratio = 0.to_sym
			else
				@profile.ratio = (@profile.victories.to_f / (@profile.defeats.to_f + @profile.victories.to_f)).to_i
			end
			if @profile.update_attributes(params[:profile])
				redirect_to @profile, :notice => 'New Ratio updated !'
			else

		end

end
end
