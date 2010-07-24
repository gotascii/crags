module Crags
  module Search
    class Country
      include Search
      attr_reader :country, :interval

      def initialize(opts = {})
        super(opts)
        @country = @opts[:country]
        @interval = @opts[:interval]
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