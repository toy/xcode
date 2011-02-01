module Xcode
  class Project
    class Config
      autoload :Decomment,  'xcode/project/config/decomment'
      autoload :IOScanner,  'xcode/project/config/io_scanner'
      autoload :ObjectNode, 'xcode/project/config/object_node'
      autoload :ArrayNode,  'xcode/project/config/array_node'

      attr_reader :path, :pbxproj_path, :root
      def initialize(path)
        @path = Pathname(path)
        @pbxproj_path = path + 'project.pbxproj'
        parse
      end

      def parse
        @root = nil
        File.open(pbxproj_path) do |io|
          ios = IOScanner.new(io)
          token = ios.tokenize
          raise 'Unable to deserialize root object.' if token != ?{
          @root = ObjectNode.new(io)
        end
      end
    end
  end
end
