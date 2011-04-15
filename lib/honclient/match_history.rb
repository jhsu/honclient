module HoN
  class MatchHistory < Stats
    attr_accessor :match_ids, :matches
    @@request_types = [:ranked_history, :casual_history, :public_history]

    def initialize(nick, request_type=:ranked_history, limit=20)
      @nickname = nick
      @stats = {}
      @matches = []
      @match_ids = []
      data = fetch(request_type, :opt => "nick", :"nick[]" => @nickname)
      @stats = data.css("ranked_history")
      dom_matches = @stats.css('match')[0..(limit - 1)]
      dom_matches.each do |match|
        @match_ids << match.css('id').first.content.to_i
      end
    end

  end
end
