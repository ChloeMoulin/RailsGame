class LocationsController < ApplicationController
  before_filter :set_location, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:search].present?
      @locations = Location.near(params[:search],50, :order => :distance)
    else
      @locations = Location.all
    end
    respond_with(@locations)
  end

  def show
    respond_with(@location)
  end

  def new
    @location = Location.new
    respond_with(@location)
  end

  def edit
  end

  def create
    @location = Location.new(params[:location])
    @location.save
    respond_with(@location)
  end

  def update
    @location.update_attributes(params[:location])
    respond_with(@location)
  end

  def destroy
    @location.destroy
    respond_with(@location)
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end
end
