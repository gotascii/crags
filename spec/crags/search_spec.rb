require 'spec_helper'

describe Search do
  class TestClass
    include Search
  end

  before do
    Crags::Config.defaults[:keyword] = "cribz"
    Crags::Config.defaults[:category] = "cribcat"
    @default_obj = TestClass.new
    @custom_obj = TestClass.new(:keyword => 'zaks', :category => 'catz')
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