module Crags
  class Runner
    include Searcher

    def search_location(keyword, loc, category = 'sss')
      puts "Searching #{loc}..."
      super
    end
  end
end