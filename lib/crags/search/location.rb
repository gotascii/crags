module Crags
  module Search
    class Location
      include ERB::Util
      include Fetcher

      def initialize(keyword, category, location)
        @keyword = keyword
        @category = category
        @location = location
      end

      def url
        "#{location.url}/search/#{category}?query=#{url_encode(keyword)}"
      end

      def doc
        fetch_doc("#{url}&format=rss")
      end

      def items
        doc.items
      end

      def perform
        items.collect do |item|
          yield item if block_given?
          item
        end
      end
    end
  end
end