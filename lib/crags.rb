require 'curb'
require 'hpricot'
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

require 'crags/fetch'
require 'crags/proxy'
require 'crags/searcher'
require 'crags/runner'