module Xcode
  class Project
    autoload :Version, 'xcode/project/version'

    def version
      Version.new
    end
  end
end
