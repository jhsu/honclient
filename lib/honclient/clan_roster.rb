module HoN
  class ClanRoster < Stats
    attr_accessor :clan_name, :tag, :cid, :members, :stats

    def initialize(tag)
      @stats = {}
      url = "http://xml.heroesofnewerth.com/xml_requester.php?f=clan_roster&opt=tag&tag[]=#{CGI::escape(tag)}"
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      data = Nokogiri::XML.parse(xml_data)

      if clan = data.xpath("//xmlRequest/clans/clan").first
        @cid = clan['cid']
        @clan_name = clan['cname']
        @tag = clan['tag']
      end

      @members = data.xpath("//xmlRequest/clans/clan_roster/member").map {|member|
        member.children.select {|s| s['name'] == 'nickname' }.first.content
      }
    end

    def ranking(by = :mmr)
      results = @members.map {|nickname| player = PlayerStats.new(nickname) }
      results.sort_by {|player| player.send(by) }.reverse
    end
  end
end
