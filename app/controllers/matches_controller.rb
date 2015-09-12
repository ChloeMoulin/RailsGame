class MatchesController < ApplicationController

	respond_to :html

	def edit
		@match = Match.find(params[:id])
	end

	def update
		@match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
    	respond_with(@match.tournament)
    end
  end

end
