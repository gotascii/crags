module Crags
  class Search
    include ERB::Util
    include Fetcher
    attr_reader :container

    def initialize(location, keyword, category = 'sss', interval = 1, &block)
      @location = location
      @keyword = keyword
      @category = category
      @interval = interval
      @block = block
    end

    def location_url
      location.url
    end

    def url
      "#{location_url}/search/#{category}?query=#{url_encode(keyword)}"
    end

    def doc
      fetch_doc("#{url}&format=rss")
    end

    def items
      doc.items

      country.locations.collect do |loc|
        sleep(interval)
        Search.new(loc)
      end.flatten

    end

    def perform
      items.collect do |item|
        yield item if block_given?
        item
      end
      ###
      country.locations.collect do |loc|
        sleep(interval)
        loc.search(keyword, category, &block)
      end.flatten
    end
  end
end