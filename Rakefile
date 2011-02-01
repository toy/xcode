require 'rake'
require 'jeweler'
require 'rake/gem_ghost_task'

name = 'xcode'

Jeweler::Tasks.new do |gem|
  gem.name = name
  gem.summary = %Q{Rake tasks to deploy xcode project}
  gem.homepage = "http://github.com/toy/#{name}"
  gem.license = 'MIT'
  gem.authors = ['Ivan Kuchin']
  gem.add_runtime_dependency 'plist'
  gem.add_runtime_dependency 'net-github-upload'
  gem.add_runtime_dependency 'keychain_services'
  gem.add_development_dependency 'jeweler', '~> 1.5.2'
  gem.add_development_dependency 'rake-gem-ghost'
end
Jeweler::RubygemsDotOrgTasks.new
Rake::GemGhostTask.new
