module Xcode
  class Project
    autoload :PlistChanger, 'xcode/project/plist_changer'
    autoload :Version,      'xcode/project/version'
    autoload :Build,        'xcode/project/build'
    autoload :Config,       'xcode/project/config'
    autoload :Packer,       'xcode/project/packer'
    autoload :Tagger,       'xcode/project/tagger'

    attr_reader :path
    def initialize(path)
      @path = Pathname(path)
    end

    def name
      path.basename(path.extname).to_s
    end

    def variables
      @variables ||= {}
    end

    attr_writer :configuration
    def configuration
      @configuration ||= 'Release'
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

    def packer
      Packer.new(self)
    end

    def tagger
      Tagger.new(self)
    end
  end
end
