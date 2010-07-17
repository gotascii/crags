require File.dirname(__FILE__) + '/../spec_helper'

describe Crags::Runner do
  before do
    @runner = Crags::Runner.new
    @runner.stub!(:fetch_doc)
    @runner.stub!(:items).and_return([])
  end

  it "includes searcher" do
    Crags::Runner.ancestors.include?(Crags::Searcher).should == true
  end

  it "puts message with loc" do
    @runner.should_receive(:puts).with { |val| val =~ /location/ }
    @runner.search_location("", "location", "category")
  end

  it "takes a category" do
    @runner.search_location("", "location", "category")
  end

  it "has default category sss" do
    @runner.search_location("", "location")
  end
end