module GoMatsuoka
  class Initializer
    autoload :Database, '../application/database'

    attr_accessor :config

    def initialize(config)
      super()
      @config = config
      GoMatsuoka::Application::Database.new(@config)

      if @config.is_first_run?
        # anything that is required to be setup should
        # go in here
        setup_db
      end

      load_models
    end

    def setup_db
      migrate_db_tables
    end

    def migrate_db_tables
      migrations_dir = "#{File.dirname(__FILE__)}/initializer/migrations"
      ActiveRecord::Migration.verbose = true
      ActiveRecord::Migrator.migrate migrations_dir
    end

    # load the different models into the application
    def load_models
      Dir[File.dirname(__FILE__) + "#{File::SEPARATOR}models#{File::SEPARATOR}*.rb"].each do |file|
        load file
      end
    end
  end
end
