module HoN
  class MatchHistory < Stats
    attr_accessor :matches
    @@request_types = [:ranked_history, :casual_history, :public_history]

    def initialize(nick, request_type=:ranked_history, limit=20)
      @nickname = nick
      @stats = {}
      @matches = []
      data = fetch(request_type, :opt => "nick", :"nick[]" => @nickname)
      @stats = data.css("ranked_history")
      dom_matches = @stats.css('match')[0..(limit - 1)]
      dom_matches.each do |match|
        @matches << Match.new(match.css('id').first.content)
      end
    end

    def hero_picks
      @matches.map {|m| m.players[@nickname]['cli_name'] }
    end

  end
end
