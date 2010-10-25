module HoN
  class PlayerStats < Stats
    MAPPINGS = {
      :psr     => "acc_pub_skill",
      :kills   => "acc_herokills",
      :assists => "acc_heroassists",
      :deaths  => "acc_deaths",
      :games   => "acc_games_played"
    }

    def initialize(nickname)
      @nickname = nickname
      @stats = {}
      begin
        url = "http://xml.heroesofnewerth.com/xml_requester.php?f=player_stats&opt=nick&nick[]=#{@nickname}"
        xml_data = Net::HTTP.get_response(URI.parse(url)).body
        data = Nokogiri::XML.parse(xml_data)
        data.xpath("//xmlRequest/stats/player_stats/stat").each do |stat|
          @stats[stat["name"]] = stat.content
        end
      rescue SocketError
        @error = "Could not contact the Newerth XML API."
      end
    end

    def kdr
      "#{(kills.to_f / deaths.to_f * 100).round / 100.0}:1"
    end

    def assists_per_game
      (assists.to_f / games.to_f * 100).round / 100.0
    end

    MAPPINGS.each do |meth, key|
      define_method meth do
        @stats[key]
      end
    end
  end
end
