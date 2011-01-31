require 'fspath'

module Xcode
  class Tasks
    autoload :Project, 'xcode/project'

    attr_reader :project

    def initialize(project_name = nil, &block)
      project_path = FSPath("#{project_name || File.basename(Dir.pwd)}.xcodeproj")
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
        arguments = %w[xcodebuild]
        arguments += %W[-project #{project.path}]
        arguments += %W[-configuration #{project.configuration}]
        arguments += project.variables.map{ |key, value| "#{key}=#{value}" }
        arguments += %w[clean build]

        sh *arguments
      end

      desc 'pack'
      task :pack do
        pkg_dir = FSPath('pkg')
        pack_path = pkg_dir + "#{project.name}-#{project.version}.zip"
        if pack_path.exist?
          abort "#{pack_path} already exists"
        else
          Rake::Task['build'].invoke

          products = []
          objects = project.config.root['objects']
          objects.each do |_, object|
            if reference = object['productReference']
              products << objects[reference]['path']
            end
          end

          arguments = %w[ditto -c -k]
          arguments += products.map{ |product| FSPath('build') / project.configuration / product }.select(&:exist?)
          arguments << pack_path

          sh *arguments
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
