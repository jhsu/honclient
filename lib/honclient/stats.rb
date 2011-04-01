module HoN
  class Stats
    attr_accessor :stats
    attr_reader :error
    
    def nickname
      @stats["nickname"] || "Unknown"
    end

    def stat(key)
      @stats[key] || 0
    end

    def dump_xml_stats
      @stats
    end

    def error?
      !!@error
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
    
    def respond_to?(meth, *args, &block)
      @stats.has_key?(meth.to_s) || super(meth, *args, &block)
    end
  end
end
