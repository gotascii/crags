module Crags
  module Fetch
    def fetch_doc(url)
      Hpricot.parse(fetch_html(url))
    end

    def fetch_html(url)
      Curl::Easy.perform(url).body_str
    end
  end
end