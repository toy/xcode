require 'keychain'
require 'net/github-upload'

module Xcode
  class Project
    class Packer
      attr_reader :project
      def initialize(project)
        @project = project
      end

      def pack_path
        @pack_path ||= begin
          pkg_dir = Pathname('pkg')
          pkg_dir.mkpath
          pkg_dir + "#{project.name}-#{project.version}.tbz"
        end
      end

      def pack_description
        @pack_description ||= "#{project.name} v#{project.version}"
      end

      def product_names
        [].tap do |names|
          objects = project.config.root['objects']
          objects.each do |_, object|
            if reference = object['productReference']
              names << objects[reference]['path']
            end
          end
        end
      end

      def products_dir
        Pathname('build') + project.configuration
      end

      def build
        arguments = %w[xcodebuild]
        arguments += %W[-project #{project.path}]
        arguments += %W[-configuration #{project.configuration}]
        arguments += project.variables.map{ |key, value| "#{key}=#{value}" }
        arguments += %w[clean build]

        sh *arguments
      end

      def pack
        if pack_path.exist?
          abort "#{pack_path} already exists"
        else
          build

          arguments = %W[tar -cjf #{pack_path.expand_path}]
          arguments += product_names

          Dir.chdir products_dir do
            sh *arguments
          end
        end
      end

      def release
        unless `git remote -v` =~ /git@github\.com:([^\/]+)\/(.+?)\.git/
          abort 'can\'t find github remote'
        else
          login, repos = $1, $2
          token = Keychain.items.find{ |item| item.label[/^github.com/] && item.account == "#{login}/token" }.password

          pack

          uploader = Net::GitHub::Upload.new(:login => login, :token => token)
          uploader.upload(:repos => repos, :file => pack_path.to_s, :description => pack_description)
        end
      end
    end
  end
end
