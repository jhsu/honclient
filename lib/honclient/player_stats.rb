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
      (acc_herokills / acc_deaths).round(2)
    rescue ZeroDivisionError
      0
    end

    def ranked_kdr
      (rnk_herokills / rnk_deaths).round(2)
    rescue ZeroDivisionError
      0
    end

    def mmr
      rnk_amm_team_rating.to_f.round
    end

    def tsr
      tsr_value = ((rnk_herokills/rnk_deaths/1.1/1.15)*0.65)+
        ((rnk_heroassists/rnk_deaths/1.55)*1.20)+
        (((rnk_wins/(rnk_wins+rnk_losses))/0.55)*0.9)+
        (((rnk_gold/rnk_secs*60)/230) * (1-((230/195)*((rnk_em_played/rnk_games_played))))*0.35)+
        ((((rnk_exp/rnk_time_earning_exp*60)/380)*(1-((380/565)*(rnk_em_played/rnk_games_played))))*0.40)+
        (( ((((rnk_denies/rnk_games_played)/12)*(1-((4.5/8.5)*(rnk_em_played/rnk_games_played))))*0.70)+
           ((((rnk_teamcreepkills/rnk_games_played)/93)*(1-((63/81)*(rnk_em_played/rnk_games_played))))*0.50)+
           ((rnk_wards/rnk_games_played)/1.45*0.30))*(37.5/(rnk_secs/rnk_games_played/60)))
      if tsr_value > 10
        10
      elsif tsr_value < 0
        0
      else
        tsr_value
      end.round(2)
    rescue
      0
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
