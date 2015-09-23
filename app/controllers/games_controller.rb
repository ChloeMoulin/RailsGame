class GamesController < ApplicationController
  load_and_authorize_resource

  before_filter :set_game, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @games = Game.all
    respond_with(@games)
  end

  def show
    respond_with(@game)
  end

  def new
    @game = Game.new
    respond_with(@game)
  end

  def edit
  end

  def create
    @game = Game.new(params[:game])
    @game.save
    respond_with(@game)
  end

  def update
    @game.update_attributes(params[:game])
    respond_with(@game)
  end

  def destroy
    @game.destroy
    respond_with(@game)
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  def change_grade
    @game = Game.find(params[:id])
    @game.set_grade(params[:value])
    respond_to do |format|
      format.js
    end
  end


  private
    def set_game
      @game = Game.find(params[:id])
    end

    def games_params
      params.require(:game).permit(:name, :description, :company, :grade, :platform, :released_at, :cover)
    end
end
