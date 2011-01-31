require 'plist'

module Xcode
  class Project
    class PlistChanger
      attr_reader :plist_path

      def initialize(plist_path = 'Info.plist')
        @plist_path = plist_path
        read
      end

      def read
        set(plist[key])
      end

      def write
        plist.tap do |plist|
          plist[key] = to_s
        end.save_plist(plist_path)
      end

    private

      def key
        self.class.const_get(:KEY)
      end

      def plist
        Plist::parse_xml(plist_path)
      end
    end
  end
end
