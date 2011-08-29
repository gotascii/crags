module Crags
  module Search
    class Country < Search
      include Enumerable
      extend AttrChain
      chained_attr_accessor :country, :interval

      def initialize(opts = {})
        super
        @country = @opts[:country]
        @interval = @opts[:interval]
      end

      def locations
        country.locations
      end

      def items
        combined_items = locations.collect do |loc|
          sleep(interval)
          search = Location.new(opts.merge(:location => loc))
          search.items
        end
        combined_items.flatten
      end
      
      def each
        items.each {|i| yield i }
      end
    end
  end
end