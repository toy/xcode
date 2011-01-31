module Xcode
  class Project
    class Config
      module Decomment
        def decomment(string)
          string.gsub(/\/\/(.*)\n/, '').gsub(/\/\*(.*?)\*\//m, '').strip
        end
      end
    end
  end
end
