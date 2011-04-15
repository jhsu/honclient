module HoN
  class Match < Stats
    attr_accessor :match_id, :date, :players
    has_sections :summ, :team, :match_stats

    def initialize(match_id)
      @match_id = match_id
      @stats = {}
      data = fetch(:match_stats, :opt => "mid", :"mid[]" => match_id)
      @stats = data.css('stats match')
      map_player_stats
    end

    def player_names
      @players.keys
    end

    protected

    def map_player_stats
      @players ||= {}
      @stats.css('match_stats ms').each do |player| 
        @players[ player.css("stat[name=nickname]").first.content ] =
          player.css("stat").inject({}) {|h, v| h[v['name']] = v.content; h }
      end
    end
  end
end
