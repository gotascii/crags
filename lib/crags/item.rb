module Crags
  class Item
    attr_reader :title, :url, :date

    def initialize(elem)
      @title = elem.at("title").inner_text
      @url = elem["rdf:about"].strip_http
      @date = DateTime.parse(elem.at("dc:date").inner_text)
    end
  end
end