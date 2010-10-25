module HoN
  class PlayerStats < Stats
    MAPPINGS = {
      :psr => "acc_pub_skill"
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

    MAPPINGS.each do |meth, key|
      define_method meth do
        @stats[key]
      end
    end
  end
end
