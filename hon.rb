# A wrapper for the Heroes of Newerth XML API
# -------------------------------------------
# Author: Chris Gillis
# -------------------------------------------
#
# A list of variables for stat() can be found on the xml.heroesofnewerth.com
# website by running the relevant example query
#
# DEPENDENCIES
#   Requires rubygems
#            nokogiri
#
# USAGE:
#   require 'hon'
#   @my_stats = HoN::PlayerStats.new("account_name")
#   puts @my_stats.stat("acc_games_played")
#   @match = HoN::MatchStats.new("match_id")
#   puts @match.team_one
#   puts @match.team_two
#   puts @match.summary_stats("time_played")
#   puts @match.team_one_stats("tm_losses")


module HoN
  require 'net/http'
  require 'nokogiri'
  require './lib/stats.rb'
  require './lib/player_stats.rb'
  require './lib/match_stats.rb'
  # require './lib/player_hero_stats.rb'
end
