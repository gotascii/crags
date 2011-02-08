module Crags
  module Fetcher
    def fetch_doc(url)
      Nokogiri::XML.parse(fetch_xml(url))
    end

    def fetch_xml(url)
      req = fetch_request(url)
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