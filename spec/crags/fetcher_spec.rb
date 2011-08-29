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
    patron = mock("patron")
    patron.stub!(:body).and_return("uhh")
    should_receive(:fetch_request).with("url").and_return(patron)
    fetch_xml("url").should == "uhh"
  end

  it "creates a new request" do
    session = mock("session")
    resp = mock("resp")
    resp.stub!(:body)
    Patron::Session.should_receive(:new).and_return(session)
    session.should_receive(:get).with("url").and_return(resp)
    fetch_request("url").should == resp
  end

end