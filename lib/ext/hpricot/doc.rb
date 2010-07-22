module Hpricot
  class Doc
    def items
      search("item").collect(&:hashify)
    end
  end
end