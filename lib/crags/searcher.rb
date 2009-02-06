module Crags
  module Searcher
    include Fetch

    def strip_http(url)
      url.gsub(/^http\:\/\/(.*)/,'\1')
    end

    def location_doc
      fetch_doc("http://geo.craigslist.org/iso/us")
    end

    def location_links
      location_doc.search("#list a")
    end

    def locations
      location_links.collect{|link| strip_http(link["href"]) }
    end

    def categories
      doc = fetch_doc("http://sfbay.craigslist.org/")
      links = doc.search("table[@summary=\"for sale\"] a")
      categories = {}
      links.each do |link|
        categories[link.inner_html] = link["href"]
      end
      categories
    end

    def search(keyword, category = 'sss', &block)
      locations.collect do |loc|
        sleep(1 + rand(3))
        search_location(keyword, loc, category, &block)
      end.flatten
    end

    def items(doc)
      doc.search("item").collect do |item|
        hashify(item)
      end
    end

    def hashify(item)
      title = item.at("title").inner_text
      url = strip_http(item["rdf:about"])
      date = DateTime.parse(item.at("dc:date").inner_text)
      {:title => title, :url => url, :date => date}
    end

    def search_location(keyword, loc, category = 'sss', &block)
      doc = fetch_doc("http://#{loc}/search/#{category}?query=#{keyword}&format=rss")
      items(doc).collect do |item|
        yield item if block_given?
        item
      end
    end
  end
end