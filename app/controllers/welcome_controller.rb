class WelcomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :auth_callback

  def index
    @matchlist = []

    if session.key? :current_user
      url = URI.parse("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=#{ENV['STEAM_WEB_API_KEY']}&account_id=#{session[:current_user][:uid]}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.ssl_version = :SSLv3

      req = Net::HTTP::Get.new(url.to_s)
      res = http.start { |http|
        http.request(req)
      }

      @matchlist = JSON.load(res.body)['result']['matches'] || []

    end
  end

  def auth_callback
    auth = request.env['omniauth.auth']

    session[:current_user] = { :nickname => auth.info['nickname'],
                               :image    => auth.info['image'],
                               :uid      => auth.uid }
    redirect_to root_url
  end
end
