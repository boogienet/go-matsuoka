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
      
      def _start
        Ripl.start :binding => binding
      end
    end
  end
end
