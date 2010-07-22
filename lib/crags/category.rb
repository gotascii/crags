module Crags
  class Category
    include Fetcher

    def self.all
      doc = fetch_doc("http://sfbay.craigslist.org/")
      links = doc.search("table[@summary=\"for sale\"] a")
      categories = {}
      links.each do |link|
        categories[link.inner_html] = link["href"]
      end
      categories
    end
  end
end