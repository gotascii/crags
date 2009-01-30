begin
  require 'bones'
  Bones.setup
rescue LoadError
  load 'tasks/setup.rb'
end

ensure_in_path 'lib'
require 'crags'

task :default => 'test'

PROJ.name = 'crags'
PROJ.authors = 'Justin Marney'
PROJ.email = 'justin.marney@viget.com'
PROJ.url = 'http://github.com/vigetlabs/crags'
PROJ.version = Crags::VERSION
PROJ.rubyforge.name = 'crags'
PROJ.test.files = FileList['test/**/*_test.rb']
PROJ.spec.opts << '--color'
