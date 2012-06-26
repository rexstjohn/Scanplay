#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'net/http'

#whatever game url we need to pull the feed from
base_uri = 'http://catalog.mochimedia.com/feeds/query/?q=recommendation%3A%3E%3D3&partner_id=2a451cb43fb275ac&limit=11851'


   resp = Net::HTTP.get_response(URI.parse(base_uri))
   data = resp.body

   puts data
   # we convert the returned JSON data to native Ruby
   # data structure - a hash
   result = JSON.parse(data)

   # if the hash has 'Error' as a key, we raise an error
   if result.has_key? 'Error'
      raise "web service error"
   end

   puts result