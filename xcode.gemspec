# encoding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'xcode'
  s.version     = '0.1.6'
  s.summary     = %q{Rake tasks to deploy xcode project}
  s.homepage    = "https://github.com/toy/#{s.name}"
  s.authors     = ['Ivan Kuchin']
  s.license     = 'MIT'

  s.metadata = {
    'bug_tracker_uri'   => "https://github.com/toy/#{s.name}/issues",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{s.name}/#{s.version}",
    'source_code_uri'   => "https://github.com/toy/#{s.name}",
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w[lib]

  s.add_runtime_dependency 'plist'
  s.add_runtime_dependency 'net-github-upload'
  s.add_runtime_dependency 'keychain_services'
end
