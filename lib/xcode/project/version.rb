require 'plist'

module Xcode
  class Project
    class Version
      attr_reader :plist_path
      attr_reader :major, :minor, :patch

      VERSION_KEY = 'CFBundleShortVersionString'

      def initialize(plist_path = 'Info.plist')
        @plist_path = plist_path
        set(plist[VERSION_KEY])
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

      def to_s
        "#{major}.#{minor}.#{patch}".sub(/\.0/, '')
      end

      def write
        plist.tap do |plist|
          plist[VERSION_KEY] = to_s
        end.save_plist(plist_path)
      end

    private

      def plist
        Plist::parse_xml(plist_path)
      end
    end
  end
end
