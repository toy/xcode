module Xcode
  class Project
    class Config
      class ObjectNode < Hash
        include Decomment

        def initialize(io)
          ios = IOScanner.new(io)
          key = nil
          value = nil

          while token = ios.tokenize
            case token
            when ?}
              return
            when ?=
              key = decomment(ios.term)
              value = nil
            when ?{
              value = ObjectNode.new(io)
            when ?(
              value = ArrayNode.new(io)
            when ?;
              value = decomment(ios.term) if value.nil?
              self[key] = value
            end
          end
        end

        def isa
          self['isa']
        end
      end
    end
  end
end
