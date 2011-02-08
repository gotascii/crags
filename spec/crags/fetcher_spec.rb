require 'spec_helper'

describe Fetcher do
  before do
    extend Fetcher
  end

  it "nokogiris the fetched xml" do
    stub!(:fetch_xml).with("url").and_return("xml")
    Nokogiri::XML.should_receive(:parse).with("xml").and_return("doc")
    fetch_doc("url").should == "doc"
  end

  it "fetches a request when fetching xml" do
    curb = mock("curb")
    curb.stub!(:body_str).and_return("uhh")
    should_receive(:fetch_request).with("url").and_return(curb)
    fetch_xml("url").should == "uhh"
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
end