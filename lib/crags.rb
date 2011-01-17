require 'hpricot'
require 'curl'
require 'erb'
require 'ostruct'
require 'ext/string'
require 'ext/hpricot/elem'
require 'crags/fetcher'
require 'crags/country'
require 'crags/location'
require 'crags/category'
require 'crags/item'
require 'crags/search/search'
require 'crags/search/location'
require 'crags/search/country'

module Crags
  Config = OpenStruct.new({
    :defaults => {
      :keyword => 'bicycle',
      :category => Category.new('for sale', 'sss'),
      :country => Country.new('us'),
      :location => Location.new('sfbay.craigslist.org'),
      :interval => 1
    },
    :category_url => "http://sfbay.craigslist.org/",
    :country_url => "http://geo.craigslist.org/iso",
    :country_codes => ['jp', 'ar', 'bd', 'br', 'ca', 'cl', 'co', 'cr', 'cz', 'de', 'eg', 'gb', 'hu', 'id', 'ie', 'il', 'lb', 'my', 'nl', 'nz', 'no', 'pk', 'pa', 'ru', 'th', 'ae', 'us', 've', 'vn']
  })
end