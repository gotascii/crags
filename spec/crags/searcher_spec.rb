require File.dirname(__FILE__) + '/../spec_helper'

describe Crags::Searcher do
  before do
    extend Crags::Searcher
  end

  it "hpricots the fetched html" do
    stub!(:fetch_html).with("url").and_return("html")
    Hpricot.should_receive(:parse).with("html").and_return("doc")
    fetch_doc("url").should == "doc"
  end

  it "fetch_requests a url" do
    curb = mock("curb")
    curb.stub!(:body_str).and_return("uhh")
    should_receive(:fetch_request).with("url").and_return(curb)
    fetch_html("url").should == "uhh"
  end

  it "creates a new request" do
    req = mock("req")
    req.stub!(:follow_location=)
    req.stub!(:perform)
    Curl::Easy.should_receive(:new).with("url").and_return(req)
    fetch_request("url").should == req
  end

  it "follows redirects for fetched requests" do
    req = mock("req")
    req.should_receive(:follow_location=)
    req.should_receive(:perform)
    Curl::Easy.stub!(:new).and_return(req)
    fetch_request("url")
  end

  it "removes http:// and trailing /" do
    url = "http://omg/"
    strip_http(url).should == "omg"
  end

  it "removes http:// when there is no trailing slash" do
    url = "http://omg"
    strip_http(url).should == "omg"
  end

  it "fetches a doc at location url" do
    should_receive(:fetch_doc).with("http://geo.craigslist.org/iso/us").and_return("doc")
    location_doc('us').should == "doc"
  end

  it "gets all a tags from div with id list" do
    doc = mock
    doc.should_receive(:search).with("#list a").and_return("links")
    stub!(:location_doc).and_return(doc)
    location_links('us').should == "links"
  end

  it "generates an array of urls using a location link's href" do
    links = []
    2.times do |i|
      link = mock
      link.should_receive(:[]).with("href").and_return("http://url#{i}/")
      links << link
    end
    stub!(:location_links).and_return(links)
    locations('us').should == ["url0", "url1"]
  end

  it "generates an array with one url using location_urls last_effective_url when no links are present on location_url page" do
    stub!(:location_links).and_return([])
    req = mock
    req.should_receive(:last_effective_url).and_return('http://url.org/')
    stub!(:location_request).with('us').and_return(req)
    locations('us').should == ["url.org"]
  end

  it "searches location for each location with keyword and return list" do
    locations = ["url0", "url1"]

    locations.each do |loc|
      should_receive(:search_location).with("omg", loc, 'sss').and_return(["1#{loc}", "2#{loc}"])
    end

    stub!(:locations).and_return(locations)
    search("omg").should == ["1url0", "2url0", "1url1", "2url1"]
  end

  it "calls sleep for each location" do
    should_receive(:sleep).twice
    stub!(:locations).and_return([1,2])
    stub!(:search_location)
    search("")
  end

  it "fetches doc for search url" do
    should_receive(:fetch_doc).with("http://url/search/sss?query=keyword&format=rss")
    stub!(:items).and_return([])
    search_location("keyword", "url")
  end

  it "creates and returns items" do
    items = [1,2,3]
    should_receive(:items).and_return(items)
    search_location("keyword", "url").should == items
  end

  it "gets all item elements from doc" do
    item = stub
    stub!(:hashify).with(item).and_return(1)
    doc = mock
    doc.should_receive(:search).with("item").and_return([item])
    items(doc).should == [1]
  end

  it "hashifies all item elements from doc" do
    item = stub
    should_receive(:hashify).with(item).and_return(1)
    doc = stub
    doc.stub!(:search).and_return([item])
    items(doc).should == [1]
  end

  it "fetches doc the main sfbay page" do
    doc = stub
    doc.stub!(:search).and_return([])
    should_receive(:fetch_doc).with("http://sfbay.craigslist.org/").and_return(doc)
    categories
  end

  it "searches for all links in the table with property summary equal to for sale" do
    doc = mock
    doc.should_receive(:search).with("table[@summary=\"for sale\"] a").and_return([])
    stub!(:fetch_doc).and_return(doc)
    categories
  end

  it "generates a hash with link inner html keys and link href values" do
    link = stub
    link.stub!(:inner_html).and_return("inner_html")
    link.stub!(:[]).with("href").and_return("href")
    doc = stub
    doc.stub!(:search).and_return([link, link])
    stub!(:fetch_doc).and_return(doc)
    categories.should == {'inner_html' => 'href', 'inner_html' => 'href'}
  end

  it "accepts a category parameter" do
    should_receive(:fetch_doc).with("http://loc/search/scram?query=keyword&format=rss")
    stub!(:items).and_return([])
    search_location('keyword', 'loc', 'scram')
  end

  it "has a default category of sss" do
    should_receive(:fetch_doc).with("http://loc/search/sss?query=keyword&format=rss")
    stub!(:items).and_return([])
    search_location('keyword', 'loc')
  end

  it "passes parameter to search location" do
    stub!(:locations).and_return([0])
    should_receive(:search_location).with('keyword', 0, 'chum')
    search('keyword', 'us', 'chum')
  end

  it "calls search location with a default category of sss" do
    stub!(:locations).and_return([0])
    should_receive(:search_location).with('keyword', 0, 'sss')
    search('keyword')
  end
end