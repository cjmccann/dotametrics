class PlayersController < ApplicationController
	def new
	end

	def create
	  render plain: params[:player].inspect
  end
end
