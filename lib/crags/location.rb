module Crags
  module Location
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def url
      "http://#{domain}"
    end
  end
end