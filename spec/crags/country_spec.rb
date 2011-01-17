require 'spec_helper'

describe Country, "the class" do
  it "knows all of the codes store in the config" do
    Crags::Config.stub(:country_codes) { ["code"] }
    Country.codes.should == ["code"]
  end

  it "finds all countries" do
    Country.stub(:codes) { ["code"] }
    Country.should_receive(:new).with("code") { "country!" }
    Country.all.should == ["country!"]
  end
end

describe Country do
  before do
    @country = Country.new("us")
  end

  it "generates the url for a country" do
    Crags::Config.stub!(:country_url).and_return("country_url")
    @country.url.should == "country_url/us"
  end

  it "is initialized with a country code" do
    @country.code.should == "us"
  end

  it "fetches the doc for the country" do
    @country.stub!(:url).and_return("url")
    @country.should_receive(:fetch_doc).with("url").and_return("doc")
    @country.doc.should == "doc"
  end

  it "fetches the request for the country" do
    @country.stub!(:url).and_return("url")
    @country.should_receive(:fetch_request).with("url").and_return("request")
    @country.request.should == "request"
  end

  it "gets all a tags from div with id list" do
    doc = mock
    doc.should_receive(:search).with("#list a").and_return("links")
    @country.stub!(:doc).and_return(doc)
    @country.links.should == "links"
  end

  it "generates an array of urls using link hrefs" do
    links = []
    2.times do |i|
      link = mock
      link.should_receive(:[]).with("href").and_return("http://url#{i}/")
      links << link
    end
    @country.stub!(:links).and_return(links)
    Location.should_receive(:new).with("url0").and_return("url0")
    Location.should_receive(:new).with("url1").and_return("url1")
    @country.locations.should == ["url0", "url1"]
  end

  it "generates an array containing one url using location_urls last_effective_url when no links are present" do
    @country.stub!(:links).and_return([])
    req = mock
    req.should_receive(:last_effective_url).and_return('http://url.org/')
    @country.stub!(:request).and_return(req)
    Location.should_receive(:new).with("url.org").and_return("url.org")
    @country.locations.should == ["url.org"]
  end
end