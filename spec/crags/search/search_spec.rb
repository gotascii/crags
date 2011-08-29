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

  it "has a default keyword" do
    @default_obj.keyword.should == "cribz"
  end

  it "has a default category" do
    @default_obj.category.should == "cribcat"
  end
  
  it "sets keyword and returns self" do
    @custom_obj.keyword('ruby').should == @custom_obj
    @custom_obj.keyword.should == 'ruby'
  end
  
  it "sets category and returns self" do
    @custom_obj.category('gems').should == @custom_obj
    @custom_obj.category.should == 'gems'
  end
  
  it "sets opts and returns self" do
    @custom_obj.opts('ruby' => 'gems').should == @custom_obj
    @custom_obj.opts.should == {'ruby' => 'gems'}
  end
  
  it "sets keyword, category, opts and returns self" do
    @chain = Search::Search.new.keyword('ruby').category('gems').opts('ruby' => 'gems')
    @chain.keyword.should == 'ruby'
    @chain.category.should == 'gems'
    @chain.opts.should == {'ruby' => 'gems'}
  end
  
end