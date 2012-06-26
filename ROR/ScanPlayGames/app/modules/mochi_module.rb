module Mochi
  include HTTParty

  #whatever game url we need to pull the feed from
  base_uri "http://catalog.mochimedia.com/feeds/query/?q=recommendation%3A%3E%3D3&partner_id=2a451cb43fb275ac&limit=11851"

  def get_games
    response = HTTParty.get(base_uri)

    response.each do |item|
      #puts item['user']['screen_name']
      puts item
    end
  end
end