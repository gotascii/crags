module Crags
  module Fetcher
    def fetch_doc(url)
      Nokogiri::XML.parse(fetch_xml(url))
    end

    def fetch_xml(url)
      resp = fetch_request(url)
      resp.body
    end

    def fetch_request(url)
      session = Patron::Session.new
      resp = session.get(url)
      resp
    end
  end
end