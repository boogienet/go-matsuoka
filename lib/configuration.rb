module GoMatsuoka
  class Configuration
    def initialize
      super
      @_log_file = File.join GoMatsuoka.data_dir, "log", "#{GoMatsuoka.env}.log"
      @_data_file = File.join GoMatsuoka.data_dir, "#{GoMatsuoka.env}.sqlite3"
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
      File.exists? database
    end
  end
end
