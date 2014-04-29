module GoMatsuoka
  class Configuration
    def initialize
      super
      @_log_file = File.join GoMatsuoka.data_dir, "#{GoMatsuoka.env}.log"
      @_data_file = File.join GoMatsuoka.data_dir, "#{GoMatsuoka.env}.sqlite3"
    end
    def logger
      @_logger ||= Logger.new File.open @_log_file, "w"
      if GoMatsuoka.env.include? "development"
        # @_logger.level = Logger::DEBUG
      end
    end
    def logger=(logger)
      @_logger = logger
    end

    def log_file
      @_log_file
    end
    def log_file=(logfile)
      @_log_file = logfile
    end
    def database
      @_data_file
    end
    def database=(db)
      @_data_file = db
    end
    def is_first_run?
      !File.exists?(database)
    end
  end
end
