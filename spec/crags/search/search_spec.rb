require 'spec_helper'

describe Search::Search do
  before do
    Crags::Config.stub!(:defaults).and_return({:keyword => 'cribz', :category => 'cribcat'})
    @default_obj = Search::Search.new
    @custom_obj = Search::Search.new(:keyword => 'zaks', :category => 'catz')
  end

  it "has a custom keyword" do
    @custom_obj.keyword.should == "zaks"
  end

  it "has a custom category" do
    @custom_obj.category.should == "catz"
  end

  it "has a custom keyword" do
    @default_obj.keyword.should == "cribz"
  end

  it "has a custom category" do
    @default_obj.category.should == "cribcat"
  end
end