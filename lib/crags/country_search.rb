module Crags
  class CountrySearch
    include ERB::Util
    include Fetcher

    def initialize(country, keyword, category = 'sss', interval = 1, &block)
      @country = country
      @keyword = keyword
      @category = category
      @interval = 1
      @block = block
    end

    def locations
      country.locations
    end

    def perform
      locations.collect do |loc|
        sleep(interval)
        search = LocationSearch.new(keyword, category, &block)
        search.perform
      end.flatten
    end
  end
end