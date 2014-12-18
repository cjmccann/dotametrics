class PlayersController < ApplicationController
	def new
	end

	def create
	  #render plain: params[:player].inspect
	  @player = Player.new(player_params)

	  @player.save
	  redirect_to @player
  end

  def show
    @player = Player.find(params[:id])
  end

  def index
    @players = Player.all
  end

  private
    def player_params
      params.require(:player).permit(:username)
    end
  
end
