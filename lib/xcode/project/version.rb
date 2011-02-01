module Xcode
  class Project
    class Version < PlistChanger
      attr_reader :major, :minor, :patch

      KEY = 'CFBundleShortVersionString'

      def to_s
        "#{major}.#{minor}.#{patch}".sub(/\.0/, '')
      end

      def set(string)
        if /^(\d+)(?:\.(\d+)(?:\.(\d+))?)?/ =~ string
          @major, @minor, @patch = $1.to_i, $2.to_i, $3.to_i
          self
        else
          raise "Can't parse version #{string.inspect}"
        end
      end

      def bump_major
        @major += 1
        @minor, @patch = 0, 0
        self
      end

      def bump_minor
        @minor += 1
        @patch = 0
        self
      end

      def bump_patch
        @patch += 1
        self
      end
    end
  end
end
