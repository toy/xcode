module Xcode
  class Project
    class Config
      class IOScanner
        TOKENS = [ ?}, ?=, ?;, ?{, ?( ].freeze
        DELIMS = [ ?), ?, ].freeze

        attr_reader :term

        def initialize(io)
          @io = io
        end

        def tokenize
          @term = ''

          while c = @io.getc
            return c if TOKENS.include? c
            term << c
          end

          return nil
        end

        def delimit
          @term = ''

          while c = @io.getc
            return c if DELIMS.include? c
            term << c
          end

          return nil
        end
      end
    end
  end
end
