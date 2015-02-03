class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

	def new
	  @player = Player.new
	end

	def edit
	  @player = Player.find(params[:id])
  end

	def create
	  #render plain: params[:player].inspect
	  @player = Player.new(player_params)

    if @player.save
      redirect_to @player
    else
      render 'new'
    end

	  #puts @player.save
	  #redirect_to @player
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def player_params
      params.require(:player).permit(:username)
    end
  
end
