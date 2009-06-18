module Crags
  module Searcher
    include Fetch
    include ERB::Util

    def strip_http(url)
      url.gsub(/^http\:\/\//,'').gsub(/\/$/,'')
    end

    def location_link(country)
      "http://geo.craigslist.org/iso/#{country}"
    end

    def location_doc(country)
      fetch_doc(location_link(country))
    end

    def location_request(country)
      fetch_request(location_link(country))
    end

    def location_links(country)
      location_doc(country).search("#list a")
    end

    def locations(country)
      linkz = location_links(country)
      if linkz.empty?
        [strip_http(location_request(country).last_effective_url)]
      else
        linkz.collect{|link| strip_http(link["href"]) }
      end
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

    def search(keyword, country = 'us', category = 'sss', &block)
      locations(country).collect do |loc|
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