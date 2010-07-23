require 'bundler'
Bundler.require
require 'erb'
require 'ostruct'

module Crags
  Config = OpenStruct.new({
    :interval => 1,
    :keyword => 'bicycle',
    :category_url => "http://sfbay.craigslist.org/",
    :country_url => "http://geo.craigslist.org/iso",
    :countries => [
      'jp',
      'ar',
      'bd',
      'br',
      'ca',
      'cl',
      'co',
      'cr',
      'cz',
      'de',
      'eg',
      'gb',
      'hu',
      'id',
      'ie',
      'il',
      'lb',
      'my',
      'nl',
      'nz',
      'no',
      'pk',
      'pa',
      'ru',
      'th',
      'ae',
      'us',
      've',
      'vn'
    ]
  })
end

require 'ext/string'
require 'ext/hpricot/doc'
require 'ext/hpricot/elem'
require 'crags/fetcher'
require 'crags/country'
require 'crags/location'
require 'crags/category'