require '../test_helper'

context "Fetch" do
  setup do
    extend Crags::Fetch
  end

  specify "fetch doc should hpricot fetched html" do
    stubs(:fetch_html).with("url").returns("html")
    Hpricot.expects(:parse).with("html").returns("doc")
    fetch_doc("url").should == "doc"
  end

  specify "fetch html should curl a url" do
    curb = stub(:body_str => "uhh")
    Curl::Easy.expects(:perform).with("url").returns(curb)
    fetch_html("url").should == "uhh"
  end
end

