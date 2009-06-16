# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{crags}
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Marney"]
  s.date = %q{2009-06-16}
  s.description = %q{A library to help search across multiple craigslist locations.}
  s.email = %q{justin.marney@viget.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "lib/js/client.html"]
  s.files = [".gitignore", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "countries.yml", "crags.gemspec", "lib/core_ext.rb", "lib/crags.rb", "lib/crags/fetch.rb", "lib/crags/locations.rb", "lib/crags/proxy.rb", "lib/crags/runner.rb", "lib/crags/searcher.rb", "lib/js/client.html", "test/crags/fetch_test.rb", "test/crags/locations_test.rb", "test/crags/proxy_test.rb", "test/crags/runner_test.rb", "test/crags/searcher_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/vigetlabs/crags}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{crags}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A library to help search across multiple craigslist locations}
  s.test_files = ["test/crags/fetch_test.rb", "test/crags/locations_test.rb", "test/crags/proxy_test.rb", "test/crags/runner_test.rb", "test/crags/searcher_test.rb"]
end
