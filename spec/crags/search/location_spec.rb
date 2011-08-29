require 'spec_helper'

describe Search::Location do
  before do
    @default_loc = Crags::Location.new("default.domain.com")
    @default_cat = Crags::Category.new('for sale', 'sss/')
    @custom_loc = Crags::Location.new("custom.domain.com")
    Crags::Config.stub!(:defaults).and_return({
      :keyword => 'bicycle',
      :location => @default_loc,
      :category => @default_cat
    })
    @default = Search::Location.new
    @custom = Search::Location.new({:location => @custom_loc})
  end

  it "has config default location" do
    @default.location.should == @default_loc
  end

  it "has custom country" do
    @custom.location.should == @custom_loc
  end
  
  it "set location and returns self" do
    @custom.location("ruby.domain.com").should == @custom
    @custom.location.should == "ruby.domain.com"
  end

  it "generate a url based on location, category and keyword" do
    @default.stub!(:url_encode).with('bicycle').and_return('bicycle')
    @default.url.should == "#{@default_loc.url}/search#{@default_cat.url}?query=bicycle"
  end

  it "fetch the doc at the url with an rss format" do
    @default.stub!(:url).and_return("url")
    @default.should_receive(:fetch_doc).with("url&format=rss").and_return('doc')
    @default.doc.should == 'doc'
  end

  describe "with a doc" do
    before do
      @doc = mock
      @items = ["item"]
      @doc.stub!(:search).and_return(@items)
      @default.stub!(:doc).and_return(@doc)
      Item.stub!(:new).and_return("crags_item")
    end

    it "gets all items from the doc" do
      @doc.should_receive(:search).with("item").and_return(@items)
      @default.items
    end

    it "creates a new crags item for each doc item" do
      Item.should_receive(:new).with("item").and_return("crags_item")
      @default.items
    end

    it "gets all created items" do
      @default.items.should == ["crags_item"]
    end
    
    it "gets all items on collect and upcases" do
      @default.collect{|item| item.upcase}.should == ["CRAGS_ITEM"] 
    end
  end
end