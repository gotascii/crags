require '../test_helper'

context "Runner" do
  setup do
    @runner = Crags::Runner.new
    @runner.stubs(:fetch_doc)
    @runner.stubs(:items).returns([])
  end

  specify "runner should include searcher" do
    Crags::Runner.ancestors.should.include Crags::Searcher
  end
  
  specify "search location should puts message with loc" do
    @runner.expects(:puts).with { |val| val =~ /location/ }
    @runner.search_location("", "location", "category")
  end
  
  specify "search location should take a category" do
    @runner.search_location("", "location", "category")
  end

  specify "search location should have default category sss" do
    @runner.search_location("", "location")
  end
end