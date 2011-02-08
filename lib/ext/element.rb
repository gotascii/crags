module Element
  def title
    at("title").content
  end

  def url
    self["about"].strip_http
  end

  def date_str
    at("dc|date").content
  end

  def date
    DateTime.parse(date_str)
  end
end

class Nokogiri::XML::Element
  include Element
end