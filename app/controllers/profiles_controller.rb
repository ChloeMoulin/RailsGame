class ProfilesController < ApplicationController

  before_filter :authenticate, :only => [:edit, :update]
  before_filter :load_user, :only => [:edit, :update, :show]

  

  def create
    @profile =  Profile.users.new(params[:profile])
    if @profile.save
      redirect_to @profile, :notice => 'Votre profil a bien été créé.'
    end
  end

  def show
    @profile = @user.profile
    @tournaments = @user.tournaments
    @games = @profile.prepare_games_list
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

    def games_params
      params.require(:profile).permit(:avatar)
    end

end
