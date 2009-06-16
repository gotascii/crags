require File.dirname(__FILE__) + "/../test_helper"

class Crags::LocationsTest < Test::Unit::TestCase
  context "Locations constant" do
    should "have us has a key pointing to and array of country name and url" do
      Crags::Locations.us.name.should be("United States")
      Crags::Locations.us.url.should be("http://geo.craigslist.org/iso/us")
    end
  end
end