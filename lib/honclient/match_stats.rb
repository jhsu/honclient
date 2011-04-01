module HoN
  class MatchStats < Stats
    def initialize(match_id)
      @match_id = match_id
      @summary_stats    = {}
      @team_one_stats   = {}
      @team_two_stats   = {}
      @team_one_players = []
      @team_two_players = []

      begin
        url = "http://xml.heroesofnewerth.com/xml_requester.php?f=match_stats&opt=mid&mid[]=#{CGI::escape( @match_id )}"
        xml_data = Net::HTTP.get_response(URI.parse(url)).body
        data = Nokogiri::XML.parse(xml_data)

        data.xpath('//xmlRequest/stats/match/summ/stat').each do |stat|
          @summary_stats[stat["name"]] = stat.content
        end

        data.xpath("//xmlRequest/stats/match/team[@side=1]/stat").each do |stat|
          @team_one_stats[stat["name"]] = stat.content
        end

        data.xpath("//xmlRequest/stats/match/team[@side=2]/stat").each do |stat|
          @team_two_stats[stat["name"]] = stat.content
        end

        data.xpath("//xmlRequest/stats/match/match_stats/ms").each do |ms|
          temp = {}
          team = 0

          ms.children.each do |stat|
            if stat["name"] == "team"
              team = stat.content.to_i
            end
            temp[stat["name"]] = stat.content
          end

          if team == 1
            @team_one_players.push(temp)
          else
            @team_two_players.push(temp)
          end
        end
      rescue SocketError
        @error = "Could not contact the Newerth XML API."
      end
    end

    def team_one
      @team_one_players
    end

    def team_two
      @team_two_players
    end

    def match_id
      if defined? @match_id
        @match_id
      else
        nil
      end
    end

    def summary_stats(key)
      @summary_stats[key] || 0
    end

    def team_one_stats(key)
      @team_one_stats[key] || 0
    end

    def team_two_stats(key)
      @team_two_stats[key] || 0
    end

    def dump_xml_stats
      [@summary_stats, @team_one_stats, @team_two_stats, @team_one_players]
    end
  end
end
