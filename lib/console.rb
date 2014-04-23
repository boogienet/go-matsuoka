require 'gomatsuoka'
require 'ripl'

module GoMatsuoka
  module Console
    class << self
      def app
        @_app ||= GoMatsuoka::Application.new
      end
      def app=(a)
        @_app = a
      end

      def import_projects(file)
        f = File.open(file)
        f
      end

      def _start
        Ripl.config[:prompt] = lambda { "#{Dir.pwd} [#{GoMatsuoka.env}] > " }
        Ripl.start :binding => binding
      end
    end
  end
end
