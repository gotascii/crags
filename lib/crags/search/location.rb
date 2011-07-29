module Crags
  module Search
    class Location < Search
      include ERB::Util
      include Enumerable
      include Fetcher
      extend AttrChain
      chained_attr_accessor :location

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
        doc.search("item").collect do |elem|
          Item.new(elem)
        end
      end
      
      def each
        items.each { |item| yield item }
      end
    end
  end
end