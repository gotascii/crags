require 'spec_helper'

describe Search::Country do
  before do
    Crags::Config.stub!(:defaults).and_return({:country => 'heya', :interval => 200})
    @default = Search::Country.new
    @custom = Search::Country.new({:country => 'gabba', :interval => 10})
  end

  it "has config default country" do
    @default.country.should == "heya"
  end

  it "has config default interval" do
    @default.interval.should == 200
  end

  it "has custom country" do
    @custom.country.should == "gabba"
  end

  it "has config default interval" do
    @custom.interval.should == 10
  end

  it "delegates locations to country" do
    @default.country.should_receive(:locations).and_return("locations")
    @default.locations.should == "locations"
  end

  describe "with location searches" do
    before do
      @search = stub
      @search.stub!(:items)
      Search::Location.stub!(:new).and_return(@search)
      @locations = ["loc1", "loc2"]
      @custom.stub!(:sleep)
    end

    it "calls sleep with interval for each location" do
      @custom.stub!(:locations).and_return(@locations)
      @custom.should_receive(:sleep).with(10).twice
      @custom.items
    end

    it "creates a new search for each location" do
      Search::Location.should_receive(:new).twice.and_return(@search)
      @custom.stub!(:locations).and_return(@locations)
      @custom.items
    end

    it "performs the search for each location" do
      @search.should_receive(:items).twice
      @custom.stub!(:locations).and_return(@locations)
      @custom.items
    end

    it "flattens the search results" do
      collect = mock
      collect.should_receive(:flatten).and_return("flat!")
      locations = stub
      locations.stub!(:collect).and_return(collect)
      @custom.stub!(:locations).and_return(locations)
      @custom.items.should == "flat!"
    end
    
    it "collects the search results" do
      collect = mock
      collect.should_receive(:flatten).and_return(["flat", "items"])
      locations = stub
      locations.stub!(:collect).and_return(collect)
      @custom.stub!(:locations).and_return(locations)
      @custom.collect{|x| x.upcase}.should == ["FLAT", "ITEMS"]
    end
    
  end
end