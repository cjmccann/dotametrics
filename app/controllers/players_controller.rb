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

	  url = URI.parse("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=C99E2FDFEFD565DEA13ACCF46EE9C170&player_name=#{params[:player][:username]}")
	  
    req = Net::HTTP::Get.new(url.to_s)
    #res = Net::HTTP.start(url.host, url.port) { |http|
    #  http.request(req)
    #}


    if @player.save
      #render plain: params[:player][:username]
      #redirect_to @player
      render plain: url.to_s
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
