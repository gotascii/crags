module Crags
  module Searcher
    include Fetcher
    include ERB::Util

    def categories
      doc = fetch_doc("http://sfbay.craigslist.org/")
      links = doc.search("table[@summary=\"for sale\"] a")
      categories = {}
      links.each do |link|
        categories[link.inner_html] = link["href"]
      end
      categories
    end

    def search(keyword, country = 'us', category = 'sss', interval = 1, &block)
      locations(country).collect do |loc|
        sleep(interval)
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
      url = item["rdf:about"].strip_http
      date = DateTime.parse(item.at("dc:date").inner_text)
      {:title => title, :url => url, :date => date}
    end

    def search_location_link(keyword, loc, category = 'sss')
      "http://#{loc}/search/#{category}?query=#{url_encode(keyword)}"
    end

    def search_location(keyword, loc, category = 'sss', &block)
      doc = fetch_doc("#{search_location_link(keyword, loc, category)}&format=rss")
      items(doc).collect do |item|
        yield item if block_given?
        item
      end
    end
  end
end