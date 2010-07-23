module Crags
  module Search
    class Country
      def initialize(keyword, category, country, interval)
        @country = country
        @keyword = keyword
        @category = category
        @interval = 1
      end

      def locations
        country.locations
      end

      def perform(&block)
        locations.collect do |loc|
          sleep(interval)
          search = Search::Location.new(keyword, category, &block)
          search.perform
        end.flatten
      end
    end
  end
end