module Xcode
  class Project
    class Config
      class ArrayNode < Array
        include Decomment

        def initialize(io)
          ios = IOScanner.new(io)

          while delim = ios.delimit
            case delim
            when ?)
              return
            when ?,
              item = decomment(ios.term)
              self << item
            end
          end
        end
      end
    end
  end
end
