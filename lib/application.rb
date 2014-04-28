require 'configuration'
require 'initializer'

module GoMatsuoka

  class Application
    autoload :Database, 'application/database'

    attr_accessor :configuration, :initializer, :id
    attr_accessor :app_id

    def initialize()
      super()
      @configured = false
      @initialized = false

      @configuration = GoMatsuoka::Configuration.new
      @initializer = GoMatsuoka::Initializer.new(@configuration)

      @configured = true if !@initializer.nil?
      @initialized = true if !@configuration.nil?
    end

    def testing
      r = Resource.new
      puts r
    end

    def configured?
      @configured
    end
    def initialized?
      @initialized
    end
  end
end

