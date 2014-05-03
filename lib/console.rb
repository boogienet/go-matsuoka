require 'ripl'
require 'hirb'
require 'rb-readline'

module GoMatsuoka
  module Console
    class << self
      def initialize
        super

        # http://tagaholic.me/2009/03/13/hirb-irb-on-the-good-stuff.html
        # http://stackoverflow.com/questions/1731826/ruby-configure-irb-to-pretty-inspect-by-default

        # load the necessary libraries
        reload!

      end
      def reload!
        load "gomatsuoka.rb"
        load "console/helper.rb"
        load "console/utility.rb"
        load "console/displayer.rb"
        load "console/generator.rb"
        @_app = GoMatsuoka::Application.new
        setup
      end
      def setup
        build_easy_access(Resource)
        build_easy_access(Project)
        build_easy_access(Service)
        nil
      end

      def generate
        Generator
      end
      def help_me
        Helper
      end

      def app
        @_app ||= GoMatsuoka::Application.new
      end
      def app=(a)
        @app = a
      end

      # create an instance variable for each object from the short name
      def build_easy_access(clss)
        clss.active.each do |object_instance|
          if object_instance.respond_to?("short_name=")
            unless object_instance.short_name.empty?
              short_name = object_instance.short_name
              self.class.send(:attr_accessor, short_name)
              instance_variable_set("@#{short_name}", object_instance)
            end
          end
        end
      end

      def _start
        self.initialize
        Ripl.config[:prompt] = lambda { "#{Dir.pwd} [#{GoMatsuoka.env}] > " }
        Ripl.start :binding => binding
      end
    end
  end
end
