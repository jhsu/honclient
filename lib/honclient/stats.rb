module HoN
  class Stats
    attr_accessor :stats, :response, :nickname, :clan_tag
    attr_reader :error

    class << self
      attr_accessor :stat_prefix, :sections
      def has_sections(*sects)
        self.sections = sects
      end
    end

    def base_url
      "http://xml.heroesofnewerth.com/xml_requester.php"
    end

    def fetch(method_name, args={})
      args = args.map {|k,v| "#{k}=#{v}" }.join('&')
      url = base_url + "?f=#{method_name}&#{args}"
      @response = Net::HTTP.get_response(URI.parse(url))
      if @response.code == "200"
        parse(@response.body)
      else
        nil
      end
    rescue SocketError
      nil
    end

    def parse(response)
      Nokogiri::XML.parse(response)
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
