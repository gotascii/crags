module Hpricot
  class Elem
    def hashify
      title = at("title").inner_text
      url = ["rdf:about"].strip_http
      date = DateTime.parse(at("dc:date").inner_text)
      {:title => title, :url => url, :date => date}
    end
  end
end