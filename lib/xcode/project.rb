module Xcode
  class Project
    autoload :PlistChanger, 'xcode/project/plist_changer'
    autoload :Version,      'xcode/project/version'
    autoload :Build,        'xcode/project/build'
    autoload :Config,       'xcode/project/config'

    attr_reader :path
    def initialize(path)
      @path = path
    end

    def version
      Version.new
    end

    def build
      Build.new
    end

    def config
      Config.new(path)
    end
  end
end
