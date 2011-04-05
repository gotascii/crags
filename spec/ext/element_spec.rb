require 'spec_helper'

class Tester
  include Element
end

describe Nokogiri::XML::Element do
  before do
    @elem = Tester.new
  end

  it "uses the inner_text of title element for title" do
    title = stub
    title.stub!(:content).and_return("title!")
    @elem.stub!(:at).with("title").and_return(title)
    @elem.title.should == "title!"
  end

  it "rdf:about attribute for the url" do
    @elem.stub!(:[]).with("about").and_return("url!")
    @elem.url.should == "url!"
  end

  it "uses the inner_text of the dc:date element for date_str" do
    date = stub
    date.stub!(:inner_text).and_return("date!")
    @elem.stub!(:xpath).with("dc:date").and_return(date)
    @elem.date.should == "date!"
  end

end