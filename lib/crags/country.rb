module Crags
  class Country
    include Fetcher
    attr_reader :code

    def self.codes
      Config.country_codes
    end

    def self.all
      codes.collect {|code| new(code)}
    end

    def initialize(code)
      @code = code
    end

    def url
      "#{Config.country_url}/#{code}"
    end

    def doc
      fetch_doc(url)
    end

    def request
      fetch_request(url)
    end

    def links
      doc.search("#list a")
    end

    def locations
      if links.empty?
        str = request.last_effective_url
        [Location.new(str.strip_http)]
      else
        links.collect do |link|
          Location.new(link["href"].strip_http)
        end
      end
    end
  end
end