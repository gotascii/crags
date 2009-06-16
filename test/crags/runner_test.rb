require File.dirname(__FILE__) + '/../test_helper'

class Crags::RunnerTest < Test::Unit::TestCase
  context "instance of Runner" do
    setup do
      @runner = Crags::Runner.new
      @runner.stubs(:fetch_doc)
      @runner.stubs(:items).returns([])
    end

    should "runner should include searcher" do
      Crags::Runner.ancestors.include?(Crags::Searcher).should == true
    end

    should "search location should puts message with loc" do
      @runner.expects(:puts).with { |val| val =~ /location/ }
      @runner.search_location("", "location", "category")
    end

    should "search location should take a category" do
      @runner.search_location("", "location", "category")
    end

    should "search location should have default category sss" do
      @runner.search_location("", "location")
    end
  end
end