require '../test_helper'

context "Searcher" do
  setup do
    extend Crags::Searcher
    stubs(:sleep)
  end

  specify "fetch doc should hpricot fetched html" do
    stubs(:fetch_html).with("url").returns("html")
    Hpricot.expects(:parse).with("html").returns("doc")
    fetch_doc("url").should == "doc"
  end
end

context "Searcher with stubbed fetch doc" do
  setup do
    extend Crags::Searcher
    stubs(:sleep)
    stubs(:fetch_doc)
  end

  specify "location doc should fetch doc at location url" do
    expects(:fetch_doc).with("http://geo.craigslist.org/iso/us").returns("doc")
    location_doc.should == "doc"
  end

  specify "location links should get all a tags from div with id list" do
    doc = mock { expects(:search).with("#list a").returns("links") }
    stubs(:location_doc).returns(doc)
    location_links.should == "links"
  end

  specify "locations should return array of urls using a location link's href" do
    links = []
    2.times do |i|
      links << mock {|m| m.expects(:[]).with("href").returns("url#{i}") }
    end
    stubs(:location_links).returns(links)
    locations.should == ["url0", "url1"]
  end

  specify "search should search location for each location with keyword and return list" do
    locations = ["url0", "url1"]

    locations.each do |loc|
      expects(:search_location).with("omg", loc, 'sss').returns(["1#{loc}", "2#{loc}"])
    end

    stubs(:locations).returns(locations)
    search("omg").should == ["1url0", "2url0", "1url1", "2url1"]
  end

  specify "search should call sleep for each location" do
    expects(:sleep).times(2)
    stubs(:locations).returns([1,2])
    stubs(:search_location)
    search("")
  end

  specify "search location should fetch doc for search url" do
    expects(:fetch_doc).with("urlsearch/sss?query=keyword&format=rss")
    stubs(:items).returns([])
    search_location("keyword", "url")
  end

  specify "search location should create link with each item in doc items and return list" do
    items = [1,2,3]
    expects(:items).returns(items)
    items.each do |i|
      expects(:create_link).with(i).returns("omg#{i}")
    end
    search_location("keyword", "url").should == ['omg1','omg2','omg3']
  end

  specify "fetch html should curl a url" do
    curb = stub(:body_str => "uhh")
    Curl::Easy.expects(:perform).with("url").returns(curb)
    fetch_html("url").should == "uhh"
  end

  specify "create link should return an a href based on item element" do
    inner_text = mock(:inner_text=>"text")
    item = mock do |l|
      expects(:[]).with("rdf:about").returns("link")
      expects(:at).with("title").returns(inner_text)
    end

    create_link(item).should == "<a href=\"link\">text</a>"
  end

  specify "items should get all item elements from doc" do
    doc = mock { expects(:search).with("item").returns(1) }
    items(doc).should == 1
  end

  specify "categories should fetch doc the main sfbay page" do
    doc = stub(:search => [])
    expects(:fetch_doc).with("http://sfbay.craigslist.org/").returns(doc)
    categories
  end

  specify "categories should search for all links in the table with property summary equal to for sale" do
    doc = mock { expects(:search).with("table[@summary=\"for sale\"] a").returns([]) }
    stubs(:fetch_doc).returns(doc)
    categories
  end

  specify "categories should return a hash with link inner html keys and link href values" do
    link = stub(:inner_html => "inner_html") do
      stubs(:[]).with("href").returns("href")
    end

    doc = stub(:search => [link, link])
    stubs(:fetch_doc).returns(doc)
    categories.should == {'inner_html' => 'href', 'inner_html' => 'href'}
  end

  specify "search location should accept a category parameter" do
    expects(:fetch_doc).with("locsearch/scram?query=keyword&format=rss")
    stubs(:items).returns([])
    search_location('keyword', 'loc', 'scram')
  end

  specify "search location default category is sss" do
    expects(:fetch_doc).with("locsearch/sss?query=keyword&format=rss")
    stubs(:items).returns([])
    search_location('keyword', 'loc')
  end

  specify "search should pass parameter to search location" do
    stubs(:locations).returns([0])
    expects(:search_location).with('keyword', 0, 'chum')
    search('keyword', 'chum')
  end
  
  specify "search should have default category of sss" do
    stubs(:locations).returns([0])
    expects(:search_location).with('keyword', 0, 'sss')
    search('keyword')
  end
end
