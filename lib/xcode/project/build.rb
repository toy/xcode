require 'plist'

module Xcode
  class Project
    class Build < PlistChanger
      attr_reader :number

      KEY = 'CFBundleVersion'

      def to_s
        number.to_s
      end

      def set(string)
        if /^(\d+)/ =~ string
          @number = $1.to_i
          self
        else
          raise "Can't parse build #{string.inspect}"
        end
      end

      def increment
        @number += 1
        self
      end
    end
  end
end
