# rubygems here so 'rake spec' works
require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)
require 'crags'
include Crags