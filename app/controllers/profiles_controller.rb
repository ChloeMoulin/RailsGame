class ProfilesController < ApplicationController

	before_filter :ratio_calc, only: [:create, :save]
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :load_user, :only => [:edit, :update]

	def create
		@profile =  Profile.users.new(params[:profile])
		if @profile.save
			redirect_to @profile, :notice => 'Votre profil a bien été créé.'
		else
			
		end
	end

	def update
		@profile = user.profile
		if @profile.update_attributes(params[:profile])
			redirect_to @profile, :notice => 'Updated your profile information successfully.'
		else
		end
	end

	private
		def load_user
			@user = current_user
		end

		def ratio_calc
			@profile = Profile.find(params[:id])
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
