module Crags
  module Search
    def self.included(base)
      base.class_eval do
        attr_reader :keyword, :category

        def initialize(opts = {})
          @opts = Config.defaults.merge(opts)
          @keyword = @opts[:keyword]
          @category = @opts[:category]
        end
      end
    end
  end
end