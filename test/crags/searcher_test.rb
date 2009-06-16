require File.dirname(__FILE__) + '/../test_helper'

class Crags::SearcherTest < Test::Unit::TestCase

  context "Searcher with stubbed fetch doc" do
    setup do
      extend Crags::Searcher
      stubs(:sleep)
      stubs(:fetch_doc)
    end

    should "strip_http should remove http:// and trailing /" do
      url = "http://omg/"
      strip_http(url).should == "omg"
    end

    should "location doc should fetch doc at location url" do
      expects(:fetch_doc).with("http://geo.craigslist.org/iso/us").returns("doc")
      country = Crags::Locations.us
      location_doc(country).should == "doc"
    end

    should "location links should get all a tags from div with id list" do
      doc = mock { expects(:search).with("#list a").returns("links") }
      stubs(:location_doc).returns(doc)
      location_links('us').should == "links"
    end

    should "locations should return array of urls using a location link's href" do
      links = []
      2.times do |i|
        links << mock {|m| m.expects(:[]).with("href").returns("http://url#{i}/") }
      end
      stubs(:location_links).returns(links)
      locations.should == ["url0", "url1"]
    end

    should "search should search location for each location with keyword and return list" do
      locations = ["url0", "url1"]

      locations.each do |loc|
        expects(:search_location).with("omg", loc, 'sss').returns(["1#{loc}", "2#{loc}"])
      end

      stubs(:locations).returns(locations)
      search("omg").should == ["1url0", "2url0", "1url1", "2url1"]
    end

    should "search should call sleep for each location" do
      expects(:sleep).times(2)
      stubs(:locations).returns([1,2])
      stubs(:search_location)
      search("")
    end

    should "search location should fetch doc for search url" do
      expects(:fetch_doc).with("http://url/search/sss?query=keyword&format=rss")
      stubs(:items).returns([])
      search_location("keyword", "url")
    end

    should "search location should create return items" do
      items = [1,2,3]
      expects(:items).returns(items)
      search_location("keyword", "url").should == items
    end

    should "items should get all item elements from doc" do
      item = stub
      stubs(:hashify).with(item).returns(1)
      doc = mock { expects(:search).with("item").returns([item]) }
      items(doc).should == [1]
    end

    should "items should hashify all item elements from doc" do
      item = stub
      expects(:hashify).with(item).returns(1)
      doc = stub { stubs(:search).returns([item]) }
      items(doc).should == [1]
    end

    should "categories should fetch doc the main sfbay page" do
      doc = stub(:search => [])
      expects(:fetch_doc).with("http://sfbay.craigslist.org/").returns(doc)
      categories
    end

    should "categories should search for all links in the table with property summary equal to for sale" do
      doc = mock { expects(:search).with("table[@summary=\"for sale\"] a").returns([]) }
      stubs(:fetch_doc).returns(doc)
      categories
    end

    should "categories should return a hash with link inner html keys and link href values" do
      link = stub(:inner_html => "inner_html") do
        stubs(:[]).with("href").returns("href")
      end

      doc = stub(:search => [link, link])
      stubs(:fetch_doc).returns(doc)
      categories.should == {'inner_html' => 'href', 'inner_html' => 'href'}
    end

    should "search location should accept a category parameter" do
      expects(:fetch_doc).with("http://loc/search/scram?query=keyword&format=rss")
      stubs(:items).returns([])
      search_location('keyword', 'loc', 'scram')
    end

    should "search location default category is sss" do
      expects(:fetch_doc).with("http://loc/search/sss?query=keyword&format=rss")
      stubs(:items).returns([])
      search_location('keyword', 'loc')
    end

    should "search should pass parameter to search location" do
      stubs(:locations).returns([0])
      Crags::Locations.stubs(:us).returns("us")
      expects(:search_location).with('keyword', 0, 'chum')
      search('keyword', 'us', 'chum')
    end

    should "search should have default category of sss" do
      stubs(:locations).returns([0])
      expects(:search_location).with('keyword', 0, 'sss')
      search('keyword')
    end
  end
end