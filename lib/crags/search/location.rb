module Crags
  module Search
    class Location
      include ERB::Util
      include Fetcher
      include Search
      attr_reader :location

      def initialize(opts = {})
        super(opts)
        @location = @opts[:location]
      end

      def url
        "#{location.url}/search#{category.url}?query=#{url_encode(keyword)}"
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