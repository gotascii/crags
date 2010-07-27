module Crags
  class Item
    attr_reader :title, :url, :date

    def initialize(elem)
      @title = elem.title
      @url = elem.url
      @date = elem.date
    end
  end
end