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
      # TODO: Need to make this read all the rb files and load everything automatically
      require 'models/resource_type'
      require 'models/resource'
      require 'models/project'
      require 'models/project_type'
      require 'models/planned_commitment'
      require 'models/actual'
    end
  end
end
