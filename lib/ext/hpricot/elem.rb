module Hpricot
  class Elem
    def title
      at("title").inner_text
    end

    def url
      self["rdf:about"].strip_http
    end

    def date_str
      at("dc:date").inner_text
    end

    def date
      DateTime.parse(date_str)
    end
  end
end