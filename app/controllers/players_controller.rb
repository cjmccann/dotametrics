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
	  if params[:player][:username].empty?
      steamid = params[:player][:steamid]
    else
      username = params[:player][:username]
      
      url = URI.parse("https://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=#{ENV['STEAM_WEB_API_KEY']}&vanityurl=#{params[:player][:username]}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.ssl_version = :SSLv23

      req = Net::HTTP::Get.new(url.to_s)
      res = http.start { |http|
        http.request(req)
      }

      steamid = JSON.load(res.body)['response']['steamid']
    end

	  @player = Player.new( {:username => username, :steamid => steamid } )

    if @player.save
      redirect_to @player
    else
      render 'new'
    end
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
      params.require(:player).permit(:steamid)
    end
end
