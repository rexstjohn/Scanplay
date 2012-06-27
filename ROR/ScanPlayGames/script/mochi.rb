#!/usr/bin/env ruby
require 'rubygems'
require 'net/http'
require 'uri'
require 'HTTParty'

#note to self: must gem install httparty or this wont work
=begin
# Use the class methods to get down to business quickly
response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
puts response.body, response.code, response.message, response.headers.inspect

response.each do |item|
  puts item['user']['screen_name']
end

# Or wrap things up in your own class
class Twitter
  include HTTParty
  base_uri 'twitter.com'

  def initialize(u, p)
    @auth = {:username => u, :password => p}
  end

  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def timeline(which=:friends, options={})
    options.merge!({:basic_auth => @auth})
    self.class.get("/statuses/#{which}_timeline.json", options)
  end

  def post(text)
    options = { :query => {:status => text}, :basic_auth => @auth }
    self.class.post('/statuses/update.json', options)
  end
end

twitter = Twitter.new("rexstjohn@gmail.com", "3w0k5r00l!")
puts twitter.timeline
=end

#whatever game url we need to pull the feed from
#base_uri = 'http://catalog.mochimedia.com/feeds/query/?q=recommendation%3A%3E%3D3&partner_id=2a451cb43fb275ac&limit=11851'


#note to self: must gem install httparty or this wont work

# Use the class methods to get down to business quickly
#response = HTTParty.get(base_uri)
#puts response.body, response.code, response.message, response.headers.inspect

#response.each do |item|
 # puts item
#end
# Or wrap things up in your own class
class Mochi
  include HTTParty
  base_uri 'catalog.mochimedia.com'

  attr_accessor :partner_id

  def initialize
    @partner_id = '2a451cb43fb275ac'
  end

  # which can be :friends, :user or :public
  # options[:query] can be things like since, since_id, count, etc.
  def get_feed
    options = { :query => {:recommendation => ':>=3'}, :partner_id => @partner_id, :limit => '11851' }
    self.class.get("/feeds/query/",options)
  end

  def get_feed_with_options
    #self.class.get("/statuses/#{which}_timeline.json", options)
  end

  def get_game_zips
      
  end

  def enumerate_games
    response = get_feed

    response['games'].each do |game|

      game.each do |k,i|
        puts "key: #{k} value: #{i}"
      end
    end
  end
end

#fetch the goodness
mochi = Mochi.new
mochi.enumerate_games
#puts mochi.get_feed

