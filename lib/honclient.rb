libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

module HoN
  require 'net/http'
  require 'nokogiri'
  require 'honclient/stats'
  require 'honclient/player_stats'
  require 'honclient/match_stats'
  require 'honclient/player_hero_stats'
end
