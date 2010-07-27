require 'spec_helper'

describe Item do
  before do
    elem = stub
    elem.stub!(:title).and_return("title!")
    elem.stub!(:url).and_return("url!")
    elem.stub!(:date).and_return("date!")
    @item = Item.new(elem)
  end

  it "has a title reader" do
    @item.title.should == "title!"
  end

  it "has a url reader" do
    @item.url.should == "url!"
  end

  it "has a date reader" do
    @item.date.should == "date!"
  end
end