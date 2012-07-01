module Mochi
	class MochiHelper
	  require 'net/http'
	  require 'uri'
	  require 'HTTParty'
	  require 'json'
	  include HTTParty

	  base_uri 'catalog.mochimedia.com'

	  def partner_id
	    '2a451cb43fb275ac'
	  end

	  def limit
	    '10'
	  end

	  def recommendation
	    ':>=3'
	  end


	  def initialize
	  end

	  # which can be :friends, :user or :public
	  # options[:query] can be things like since, since_id, count, etc.
	  def get_feed
	    options = { :query => {:recommendation => recommendation}, :partner_id => self.partner_id, :limit => self.limit }
	    self.class.get("/feeds/query/",options)
	  end

	  def get_feed_with_options
	    #self.class.get("/statuses/#{which}_timeline.json", options)
	  end

	  #downloads game zips to a given directory.
	  def get_game_zips
	      
	  end

	  #enumerates the games in a feed
	  def enumerate_games
	    response = get_feed
	    games_key = 'games'

	    response[games_key].each do |game|
	      game.each do |k,v|
	        puts "key: #{k} value: #{v}"
	      end
	    end
	  end

	  #generates an active record model and migration from the json provided
	  def generate_model
	    response = get_feed
	    games_key = 'games'
	    json_attrs = Array.new#empty array of attributes

	    response[games_key].each do |game|

	      #step 1: generate the accessor list
	      #step 2: generate the template migration
	      print "attr_accessor "
	      
	      game.each do |k,i|
	        print ":#{k}, "

	        #shove that attribute in our array here
	        json_attrs << ":" + k
	      end

	      puts
	      puts "create_table :games do |t|"

	      json_attrs.each do |atr|
	          puts "t.string #{atr}"
	      end

	      puts "t.timestamps"
	      puts "end"

	      return
	    end
	  end

	  #outputs the fields supported by the model
	  def get_mochi_fields
	    response = get_feed
	    games_key = 'games'
	    json_attrs = Array.new#empty array of attributes

	    response[games_key].each do |game|
	      
	      game.each do |k,i|
	        print "#{k}, "

	        #shove that attribute in our array here
	        json_attrs << ":" + k
	      end
	      return
	    end
	  end

	  #imports a game list and stuffs it in the database
	  def import_games
	    response = get_feed
	    games_key = 'games'

	    #create games for the database
	    response[games_key].each do |game|
	      Game.create(game)
	    end
	  end
	end
end