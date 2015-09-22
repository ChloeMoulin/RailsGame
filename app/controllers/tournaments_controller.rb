class TournamentsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def list 
    @tournaments_list = Tournament.order_for_index
    respond_to do |format|
      format.js
    end
  end

  def map_show

    @location = params[:search]
    @distance = params[:distance]

    @tournaments = nil
    if @location != nil && !@location.empty? && @distance != nil
      @tournaments = Tournament.near(@location, @distance, {:units => :km})
      @loc = Location.find_by_address(@location)
      if @loc == nil
        @loc = Location.new
        @loc.address = @location
        @loc.save
      end
      @hash_location = Gmaps4rails.build_markers(@loc) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
        marker.infowindow "Your location"
        marker.json({:id => location.id})
        marker.picture({
         :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|3A9D23|000000",
         :width   => 32,
         :height  => 32
        })
      end

    elsif user_signed_in? && current_user.profile.address != nil && (@location == nil || @location.empty?) && @distance != nil
      @tournaments = Tournament.near(current_user.profile, @distance, {:units => :km})
    else
      @tournaments = Tournament.order_for_index
    end

    @hash = Gmaps4rails.build_markers(@tournaments) do |tournament, marker|
      marker.lat tournament.latitude
      marker.lng tournament.longitude
      marker.title tournament.name
      marker.infowindow render_to_string(:partial => "/info_window", :locals => {:object => tournament})
      marker.json({:id => tournament.id})
    end
    if user_signed_in? && current_user.profile.address != nil
      @hash_user = Gmaps4rails.build_markers(current_user) do |user,marker|
        marker.lat user.profile.latitude
        marker.lng user.profile.longitude
        marker.infowindow "You"
        marker.json({:id => user.id})
        marker.picture({
         :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|007FFF|000000",
         :width   => 32,
         :height  => 32
        })
      end
    @hash = @hash_user << @hash
    @hash.flatten!
    end

    if @hash_location != nil
      @hash = @hash_location << @hash
      @hash.flatten!
    end 
    respond_to do |format|
      format.js
    end
  end

  def map
    @tournaments = nil
    @tournaments_list = Tournament.order_for_index    
    @hash = Gmaps4rails.build_markers(@tournaments_list) do |tournament, marker|
      marker.lat tournament.latitude
      marker.lng tournament.longitude
      marker.title tournament.name
      marker.infowindow render_to_string(:partial => "/info_window", :locals => {:object => tournament})
      marker.json({:id => tournament.id})
    end
    if user_signed_in? && current_user.profile.address != nil
      @hash_user = Gmaps4rails.build_markers(current_user) do |user,marker|
        marker.lat user.profile.latitude
        marker.lng user.profile.longitude
        marker.infowindow "You"
        marker.json({:id => user.id})
        marker.picture({
         :url => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|007FFF|000000",
         :width   => 32,
         :height  => 32
        })
      end
    @hash = @hash_user << @hash
    @hash.flatten!
    end
    respond_to do |format|
      format.js
    end
  end

  def index
    
  end

  def show
    @tournament = Tournament.find(params[:id])
    @locations = Location.all
    @users_and_victories = User.build_ranking(@tournament)
    @hash = Gmaps4rails.build_markers(@tournament) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.title @tournament.name
      marker.infowindow render_to_string(:partial => "/info_window", :locals => {:object => @tournament})
      marker.json({:id => location.id})
    end
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

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    respond_with(@tournament)
  end

  def register
    authorize! :register, Tournament
    @tournament = Tournament.find(params[:id])
    @user = current_user

    msg = @tournament.register_for_tournament(@user)  

    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament, :notice => msg
    else
      redirect_to @tournament
    end
  end

  def register_match
    authorize! :register_match, Tournament
    @tournament = Tournament.find(params[:id])
    @game = Game.find(params[:game_id])
    @user = current_user
    if @tournament.find_a_match(@game, @user)
      redirect_to @tournament, :notice => "You've been added to a match !"
    else
      redirect_to @tournament, :alert => "Something prevented you from register for this match"
    end
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  private
    def tournaments_params
      params.require(:tournament).permit(:name, :description, :date, :max_player, :game_ids => [], :user_ids => [])
    end

end
