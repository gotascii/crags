require 'spec_helper'

class Tester
  extend AttrChain
  chained_attr_accessor :name
end

describe AttrChain do
  before do
    @tester = Tester.new
  end
  
  it "reponds to attribue name" do
    @tester.should respond_to(:name)
  end
  
  it "sets name and returns self" do
    @tester.name('ruby').should == @tester
    @tester.name.should == 'ruby'
  end
  
end