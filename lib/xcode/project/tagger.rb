require 'keychain'
require 'net/github-upload'

module Xcode
  class Project
    class Tagger
      attr_reader :project
      def initialize(project)
        @project = project
      end

      def version
        @version ||= "v#{project.version}"
      end

      def tag
        sh *%W[git tag -a #{version} -m #{"Released #{version}"}]
      end
    end
  end
end
