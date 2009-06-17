module Crags
  module Fetch
    def fetch_doc(url)
      Hpricot.parse(fetch_html(url))
    end

    def fetch_html(url)
      req = Curl::Easy.perform(url)
      req.body_str
    end

    def fetch_request(url)
      req = Curl::Easy.new(url)
      req.follow_location = true
      req.perform
      req
    end
  end
end