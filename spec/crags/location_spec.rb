require 'spec_helper'

describe Location do
  before do
    @loc = Location.new("domain.com")
  end

  it "has a domain reader" do
    @loc.domain.should == "domain.com"
  end

  it "has a url generated form the domain" do
    @loc.url.should == "http://domain.com"
  end
end