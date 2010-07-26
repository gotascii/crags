module Crags
  module Search
    class Search
      attr_reader :keyword, :category, :opts

      def initialize(opts = {})
        @opts = Config.defaults.merge(opts)
        @keyword = @opts[:keyword]
        @category = @opts[:category]
      end
    end
  end
end