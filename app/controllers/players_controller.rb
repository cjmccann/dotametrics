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
	  url = URI.parse("http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=#{ENV['STEAM_WEB_API_KEY']}&vanityurl=#{params[:player][:name]}")

    #render plain: url
    http = Net::HTTP.new(url.host, url.port)

    req = Net::HTTP::Get.new(url.to_s)
    res = http.start { |http|
      http.request(req)
    }

    #render plain: res.body

	  url = URI.parse("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV['STEAM_WEB_API_KEY']}&player_name=#{params[:player][:name]}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.ssl_version = :SSLv23

    req = Net::HTTP::Get.new(url.to_s)
    res = http.start { |http|
      http.request(req)
    }

    #render plain: res.body


    if @player.save
      #render plain: params[:player][:username]
      redirect_to @player
      #render plain: url.to_s
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
      params.require(:player).permit(:name)
    end
  
end
