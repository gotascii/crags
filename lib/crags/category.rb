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
      doc.search("div.col a").select do |link|
        (link["href"] =~ /forum/).nil?
      end
    end

    def self.all
      links.collect do |link|
        url = link["href"]
        name = link.inner_html
        Category.new(name, url)
      end
    end
  end
end