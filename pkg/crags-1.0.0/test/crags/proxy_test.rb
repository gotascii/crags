require '../test_helper'

context "Proxy" do
  setup do
    extend Crags::Proxy
  end

  specify "lists should return a list of proxy list websites" do
    lists.should == ["http://www.proxy4free.com/page1.html"]
  end

  specify "fetch lists should fetch html for each site in lists" do
    stubs(:lists).returns(["1", "2"])
    expects(:fetch_html).with("1").returns("html_1")
    expects(:fetch_html).with("2").returns("html_2")
    fetch_lists.should == ["html_1", "html_2"]
  end
  
  specify "scan should return all ips in a text blizoc" do
    text = "192.168.1.2 omg dude!! wtf.f.f.asdasd9.8.9 78.900.42.32"
    scan(text).should == ["192.168.1.2", "78.900.42.32"]
  end
end

