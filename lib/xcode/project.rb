module Xcode
  class Project
    autoload :PlistChanger,   'xcode/project/plist_changer'
    autoload :Version,        'xcode/project/version'
    autoload :Build,          'xcode/project/build'

    def version
      Version.new
    end

    def build
      Build.new
    end
  end
end
