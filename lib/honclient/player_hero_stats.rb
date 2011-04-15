module HoN
  class PlayerHeroStats < Stats
    attr_accessor :heroes, :nickname
    self.stat_prefix = "ph_"

    def initialize(nickname)
      @nickname = nickname
      @stats = {}

      data = fetch(:player_hero_stats, :opt => "nick", :"nick[]" => @nickname)
      data.xpath("//xmlRequest/stats/player_hero_stats/hero").each do |hero_pick|
        temp = {}
        # display_name = ingame_name(hero_pick['hid'])
        hero_pick.children.each do |stat|
          stat_content = stat.content =~ /\d+/ ? stat.content.to_i : stat.content
          temp[stat["name"]] = stat_content
        end
        @stats[hero_pick["cli_name"]] = temp
      end
    rescue SocketError
      @error = "Could not contact the Newerth XML API."
    end

    def usage(hero)
      @stats["Hero_#{hero.capitalize}"]['ph_used'].to_i
    end

    def ingame_name(cli_name)
    end

    def hero_stats(hero)
      @stats[cli_name(hero)]
    end

    def hero_stat_value(hero, stat)
      if hero = hero_stats(hero)
        value = hero[stat_key(stat)]
        value =~ /^\d+\z/ ? value.to_i : value
      end
    end

    def cli_name(name)
      hero_name = "Hero_" + name.to_s.split('_').map(&:capitalize).join('')
    end

    def stat_key(stat)
      "#{self.class.stat_prefix}#{stat}"
    end

    def method_missing(meth, *args, &block)
      hero_name = cli_name(meth)
      if @stats.has_key?(hero_name)
        @stats[hero_name]
      else
        super(meth, *args, &block)
      end
    end

  end
end
