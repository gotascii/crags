Gem::Specification.new do |s|
  s.name = %q{crags}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Marney"]
  s.date = %q{2009-01-30}
  s.description = %q{A library to help search across multiple craigslist locations.}
  s.email = %q{gotascii@gmail.com}
  s.extra_rdoc_files = ["History.txt", "README.txt", "lib/js/client.html"]
  s.files = [".gitignore", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "crags.gemspec", "lib/crags.rb", "lib/crags/fetch.rb", "lib/crags/proxy.rb", "lib/crags/runner.rb", "lib/crags/searcher.rb", "lib/js/client.html", "tasks/ann.rake", "tasks/bones.rake", "tasks/gem.rake", "tasks/git.rake", "tasks/manifest.rake", "tasks/notes.rake", "tasks/post_load.rake", "tasks/rdoc.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake", "test/crags/fetch_test.rb", "test/crags/proxy_test.rb", "test/crags/runner_test.rb", "test/crags/searcher_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/gotascii/crags}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{crags}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A library to help search across multiple craigslist locations}
  s.test_files = ["test/crags/fetch_test.rb", "test/crags/proxy_test.rb", "test/crags/runner_test.rb", "test/crags/searcher_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.1.1"])
    else
      s.add_dependency(%q<bones>, [">= 2.1.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.1.1"])
  end
end
