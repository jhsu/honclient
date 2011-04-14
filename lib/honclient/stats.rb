module HoN
  class Stats
    attr_accessor :stats
    attr_reader :error

    class << self
      attr_accessor :stat_prefix
    end

    def base_url
      "http://xml.heroesofnewerth.com/xml_requester.php"
    end

    def fetch(method_name, args={})
      args = args.map {|k,v| "#{k}=#{v}" }.join('&')
      url = base_url + "?f=#{method_name}&#{args}"
      Net::HTTP.get_response(URI.parse(url)).body
    end
    
    def nickname
      @stats["nickname"] || "Unknown"
    end

    def stat(key)
      @stats[key] || 0
    end

    def dump_xml_stats
      @stats
    end

    def exists?
      !stats.empty?
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
