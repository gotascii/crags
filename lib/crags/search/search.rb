module Crags
  module Search
    class Search
      extend AttrChain
      chained_attr_accessor :keyword, :category, :opts

      def initialize(opts = {})
        @opts = Config.defaults.merge(opts)
        @keyword = @opts[:keyword]
        @category = @opts[:category]
      end

    end
  end
end