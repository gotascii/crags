require 'spec_helper'

describe Category, "the class" do
  it "fetches the doc at the configured category url" do
    Crags::Config.stub!(:category_url).and_return("category_url")
    Category.should_receive(:fetch_doc).with("category_url").and_return("doc")
    Category.doc.should == 'doc'
  end

  describe "with a doc" do
    before do
      @links = [{'href' => 'whoa'}]
      @doc = stub
      Category.stub!(:doc).and_return(@doc)
    end

    it "gets all of the category links from the doc" do
      @doc.should_receive(:search).with("div.col a").and_return(@links)
      Category.links.should == @links
    end

    it "doesn't return links to forums" do
      @doc.stub!(:search).and_return(@links)
      @links.first['href'] = 'omg/forum/dude'
      Category.links.should == []
    end
  end

  it "creates an array of new Categories based on the links" do
    links = []
    2.times do
      link = {'href' => 'link_href'}
      link.stub!(:inner_html).and_return('link_inner_html')
      links << link
    end
    Category.stub!(:links).and_return(links)
    Category.should_receive(:new).with('link_inner_html', 'link_href').twice.and_return('category!')
    Category.all.should == ['category!', 'category!']
  end
end

describe Category do
  before do
    @cat = Category.new('name', 'abbr')
  end

  it "has a name reader" do
    @cat.name.should == 'name'
  end

  it "has a url reader" do
    @cat.url.should == '/abbr'
  end
end
