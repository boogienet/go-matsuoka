require 'configuration'
load 'initializer.rb'

module GoMatsuoka

  class Application
    autoload :Database, 'application/database'

    attr_accessor :configuration, :initializer

    def initialize()
      super()
      @configured = false
      @initialized = false

      @configuration = GoMatsuoka::Configuration.new
      if !@configuration.nil?
        @initializer = GoMatsuoka::Initializer.new(@configuration)
        @configured = true
      end

      @initialized = true if !@initializer.nil?
    end

    def configured?
      @configured
    end
    def initialized?
      @initialized
    end
  end
end

