module Crags
  class Country
    include Fetcher
    attr_reader :code
    URL = "http://geo.craigslist.org/iso"
    CODES = [
      'jp',
      'ar',
      'bd',
      'br',
      'ca',
      'cl',
      'co',
      'cr',
      'cz',
      'de',
      'eg',
      'gb',
      'hu',
      'id',
      'ie',
      'il',
      'lb',
      'my',
      'nl',
      'nz',
      'no',
      'pk',
      'pa',
      'ru',
      'th',
      'ae',
      'us',
      've',
      'vn'
    ]

    def initialize(code)
      @code = code
    end

    def url
      "#{URL}/#{code}"
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