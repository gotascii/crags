module Crags
  class Category
    extend Fetcher
    attr_reader :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def self.doc
      fetch_doc(Config.category_url)
    end

    def self.links
      doc.search("div.cats a")
    end

    def self.all
      links.collect do |link|
        Category.new(link.inner_html, link["href"])
      end
    end
  end
end