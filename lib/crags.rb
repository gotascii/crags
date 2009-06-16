require 'rubygems'
require 'curb'
require 'hpricot'
require 'erb'
require 'yaml'
require 'ostruct'

require File.dirname(__FILE__) + '/core_ext'

module Crags
  VERSION = '1.3.0'
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
end

require 'crags/fetch'
require 'crags/locations'
require 'crags/proxy'
require 'crags/searcher'
require 'crags/runner'