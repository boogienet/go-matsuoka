require 'gomatsuoka'
require 'ripl'
require 'rb-readline'

require 'console/helper'

module GoMatsuoka
  module Console
    class << self
      def initialize
        super
        @_app = GoMatsuoka::Application.new
        @_resources = Hash.new
        build_resources
        build_active_projects
      end
      def help_me
        Helper
      end
      def resources
        @_resources
      end
      def app
        @_app ||= GoMatsuoka::Application.new
      end
      def app=(a)
        @_app = a
      end
      def build_resources
        Resource.all.each do |resource|
          self.class.send(:attr_accessor, resource.nickname)
          instance_variable_set("@#{resource.nickname}", resource)
        end
      end
      def build_active_projects
        Project.all.each do |project|
          project_short_name = project.short_name.downcase
          self.class.send(:attr_accessor, project_short_name)
          instance_variable_set("@#{project_short_name}", project)
        end
      end
      def _run_me
        help_me.import "projects", :from=>"data/data.yml"
      end
      def _start
        self.initialize
        Ripl.config[:prompt] = lambda { "#{Dir.pwd} [#{GoMatsuoka.env}] > " }
        Ripl.start :binding => binding
      end
    end
  end
end
