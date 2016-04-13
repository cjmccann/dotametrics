class Player < ActiveRecord::Base
  after_initialize :load_matches

  validates :steamid, presence: true, 
            uniqueness: true, length: { minimum: 5 }

  has_and_belongs_to_many :matches
  has_one :stats

  def identifier 
    username.nil? ? steamid : username
  end

  def load_matches
    url = URI.parse("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{ENV['STEAM_WEB_API_KEY']}&account_id=#{steamid}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.ssl_version = :SSLv23

    req = Net::HTTP::Get.new(url.to_s)
    res = http.start { |http|
      http.request(req)
    }

    @matchlist = JSON.load(res.body)['result']['matches'] || []

    @matchlist.each do |match|
      @match = Match.new(match_id: match['match_id'])
    end
  end
end
