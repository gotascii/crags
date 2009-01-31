require 'rubygems'
require 'curb'
require 'hpricot'

module Crags
  VERSION = '1.2.0'
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
require 'crags/proxy'
require 'crags/searcher'
require 'crags/runner'