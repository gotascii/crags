require 'spec_helper'

describe String do
  it "removes http:// and trailing /" do
    url = "http://omg/"
    url.strip_http.should == "omg"
  end

  it "removes http:// when there is no trailing slash" do
    url = "http://omg"
    url.strip_http.should == "omg"
  end
end