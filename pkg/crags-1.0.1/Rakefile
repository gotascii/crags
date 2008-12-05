# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'crags'

task :default => 'spec:run'

PROJ.name = 'crags'
PROJ.authors = 'Justin Marney'
PROJ.email = 'gotascii@gmail.com'
PROJ.url = 'http://github.com/gotascii/crags'
PROJ.rubyforge_name = 'crags'

PROJ.spec_opts << '--color'

# EOF
