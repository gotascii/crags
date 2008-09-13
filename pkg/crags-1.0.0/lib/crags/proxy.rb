module Crags
  module Proxy
    include Fetch

    def lists
      ["http://www.proxy4free.com/page1.html","http://www.proxy4free.com/page3.html"]
    end

    def fetch_lists
      lists.collect {|url| fetch_html(url)}
    end

    def scan(text)
      text.scan(/\d+\.\d+\.\d+\.\d+/)
    end

    def proxies
      fetch_lists.collect{|html|scan(html)}.flatten.uniq
    end
  end
end