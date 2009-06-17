require 'rubygems'
require 'curb'
require 'hpricot'
require 'erb'

module Crags
  VERSION = '1.4.6'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR

  def self.version
    VERSION
  end

  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, *args)
  end

  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, *args)
  end

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