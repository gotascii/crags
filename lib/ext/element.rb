module Element
  def title
    at("title").content
  end

  def url
    self["about"].strip_http
  end

  def date
    xpath("dc:date").inner_text
  end
end

class Nokogiri::XML::Element
  include Element
end