module GoMatsuoka
  class Initializer
    autoload :Database, '../application/database'

    attr_accessor :config

    def initialize(config)
      super()
      @config = config
      GoMatsuoka::Application::Database.new(@config)
      load_models

      if @config.is_first_run?
        # anything that is required to be setup should
        # go in here
      end
    end

    def load_models
      require 'models/resource'
    end
  end
end
