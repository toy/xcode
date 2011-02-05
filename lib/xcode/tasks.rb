require 'pathname'

module Xcode
  class Tasks
    autoload :Project, 'xcode/project'

    attr_reader :project

    def initialize(project_name = nil, &block)
      project_path = Pathname("#{project_name || File.basename(Dir.pwd)}.xcodeproj")
      abort "project #{project_path} not found" unless project_path.directory?
      @project = Project.new(project_path)
      block.call(project)
      define_tasks
    end

    def define_tasks
      return if @defined_tasks
      @defined_tasks = true

      desc 'build'
      task :build do
        packer = project.packer
        if packer.build
          $stderr.puts "Built #{packer.product_names.join(', ')}"
        end
      end

      desc 'pack'
      task :pack do
        packer = project.packer
        if packer.pack
          $stderr.puts "Packed #{packer.product_names.join(', ')} to #{packer.pack_path}"
        end
      end

      desc 'release'
      task :release do
        packer = project.packer
        if url = packer.release
          $stderr.puts "Released #{packer.product_names.join(', ')} as #{packer.pack_path} to #{url}"
        end
      end

      desc 'tag'
      task :tag do
        tagger = project.tagger
        if tagger.tag
          $stderr.puts "Tagged with #{tagger.version}"
        end
      end

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
      task :build_number do
        puts project.build_number
      end

      namespace :build_number do
        desc 'increment build number'
        task :increment do
          build_number = project.build_number
          if build_number.increment.write
            $stderr.puts "Incremented build number to #{build_number}"
          end
        end
      end
    end
  end
end
