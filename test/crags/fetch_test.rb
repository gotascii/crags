require File.dirname(__FILE__) + '/../test_helper'

class Crags::FetchTest < Test::Unit::TestCase
  context "Fetch" do
    setup do
      extend Crags::Fetch
    end

    should "fetch doc should hpricot fetched html" do
      stubs(:fetch_html).with("url").returns("html")
      Hpricot.expects(:parse).with("html").returns("doc")
      fetch_doc("url").should == "doc"
    end

    should "fetch html should curl a url" do
      curb = stub(:body_str => "uhh")
      Curl::Easy.expects(:perform).with("url").returns(curb)
      fetch_html("url").should == "uhh"
    end

    should "create a new request" do
      req = stub(:follow_location= => nil, :perform => nil)
      Curl::Easy.expects(:new).with("url").returns(req)
      fetch_request("url").should == req
    end
    
    should "follow redirects for fetched requests" do
      req = mock(:follow_location= => nil, :perform => nil)
      Curl::Easy.stubs(:new).returns(req)
      fetch_request("url")
    end
  end
end