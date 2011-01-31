module Xcode
  class Tasks
    autoload :Project, 'xcode/project'

    attr_reader :project

    def initialize(&block)
      project_paths = Dir['*.xcodeproj']
      project_path = (Dir["#{File.basename(Dir.pwd)}.xcodeproj"] | project_paths).first
      unless project_path
        raise "no project found"
      end
      @project = Project.new(project_path)
      block.call(project)
      define_tasks
    end

    def define_tasks
      return if @defined_tasks
      @defined_tasks = true

      desc 'current version'
      task :version do
        puts project.version
      end

      namespace :version do
        desc 'write version specified using VERSION variable'
        task :write do
          version = project.version
          if version.set(ENV['VERSION']).write
            $stderr.puts "Wrote version #{version}"
          end
        end

        namespace :bump do
          %w[major minor patch].each do |level|
            desc "bump #{level}"
            task level do
              version = project.version
              if version.send("bump_#{level}").write
                $stderr.puts "Bumped version to #{version}"
              end
            end
          end
        end
      end

      desc 'current build number'
      task :build do
        puts project.build
      end

      namespace :build do
        desc 'increment build number'
        task :increment do
          build = project.build
          if build.increment.write
            $stderr.puts "Incremented build number to #{build}"
          end
        end
      end
    end
  end
end
