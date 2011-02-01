# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xcode}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Kuchin"]
  s.date = %q{2011-02-01}
  s.extra_rdoc_files = [
    "LICENSE-xcodeide",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".tmignore",
    "LICENSE-xcodeide",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/xcode.rb",
    "lib/xcode/project.rb",
    "lib/xcode/project/build.rb",
    "lib/xcode/project/config.rb",
    "lib/xcode/project/config/array_node.rb",
    "lib/xcode/project/config/decomment.rb",
    "lib/xcode/project/config/io_scanner.rb",
    "lib/xcode/project/config/object_node.rb",
    "lib/xcode/project/plist_changer.rb",
    "lib/xcode/project/version.rb",
    "lib/xcode/tasks.rb",
    "xcode.gemspec"
  ]
  s.homepage = %q{http://github.com/toy/xcode}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Rake tasks to deploy xcode project}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<plist>, [">= 0"])
      s.add_runtime_dependency(%q<fspath>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rake-gem-ghost>, [">= 0"])
    else
      s.add_dependency(%q<plist>, [">= 0"])
      s.add_dependency(%q<fspath>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rake-gem-ghost>, [">= 0"])
    end
  else
    s.add_dependency(%q<plist>, [">= 0"])
    s.add_dependency(%q<fspath>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rake-gem-ghost>, [">= 0"])
  end
end
