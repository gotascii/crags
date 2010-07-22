require 'bundler'
Bundler.require
require 'erb'

module Crags
  COUNTRIES = [
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
end

require 'ext/string'
require 'crags/fetcher'
require 'crags/searcher'
require 'crags/runner'
require 'crags/country'