module HoN
  class PlayerHeroStats < Stats
    attr_accessor :heroes, :nickname
    def initialize(nickname)
      @nickname = nickname
      @heroes = {}
      begin
        url = "http://xml.heroesofnewerth.com/xml_requester.php?f=player_hero_stats&opt=nick&nick[]=#{@nickname}"
        xml_data = Net::HTTP.get_response(URI.parse(url)).body
        data = Nokogiri::XML.parse(xml_data)
        data.xpath("//xmlRequest/stats/player_hero_stats/hero").each do |hero|
          temp = {}
          hero.children.each do |stat|
            temp[stat["name"]] = stat.content
          end
          @heroes[hero["cli_name"]] = temp
        end
      rescue SocketError
        @error = "Could not contact the Newerth XML API."
      end
    end

    def hero(name)
      @heroes["Hero_#{name.capitalize}"]
    end

    def stats(hero,key)
      if !hero.empty?
        if @heroes.has_key? hero
          if @heroes[hero].has_key? key
            @heroes[hero][key]
          end
        end
      else
        return 0
      end
    end

    def dump_xml_stats
      return @heroes
    end
  end
end
