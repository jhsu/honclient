module HoN
  class Stats
    attr_accessor :stats
    def nickname
      if @stats.has_key? "nickname"
        @stats["nickname"]
      else
        "Unknown"
      end
    end

    def stat(key)
      if @stats.has_key? key
        @stats[key]
      else
        return 0
      end
    end

    def dump_xml_stats
      @stats
    end

    def error?
      if defined? @error
        true
      else
        false
      end
    end

    def error
      @error
    end

    def method_missing(meth, *args, &block)
      if @stats.has_key?(meth.to_s)
        value = @stats[meth.to_s]
        case value
        when /^\d+/ then value.to_f
        else value
        end
      else
        super(meth, *args, &block)
      end
    end
  end
end
