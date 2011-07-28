require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "crags"
    gem.summary = %Q{A library to help search across multiple craigslist locations.}
    gem.description = %Q{A library to help search across multiple craigslist locations.}
    gem.email = "gotascii@gmail.com"
    gem.homepage = "http://github.com/gotascii/crags"
    gem.authors = ["Justin Marney"]
    gem.add_dependency 'nokogiri'
    gem.add_dependency 'curb'
    gem.add_development_dependency 'rspec'
    gem.add_development_dependency 'jeweler'    
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "crags #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
