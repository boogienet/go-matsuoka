require "gomatsuoka/version"
load "application.rb"

module GoMatsuoka
  class << self
    def env
      @_env ||= ENV['GM_ENV'] || "development"
    end

    def env=(environment)
      @_env = environment
    end

    def data_dir
      @_data_dir ||= File.join ENV['HOME'], File::SEPARATOR, '.gomatsuoka'
    end

    def data_dir=(dir)
      @_data_dir = dir
    end

    def root
      @_root ||= Dir.pwd
    end

    def root=(path)
      @_root = path
    end
  end
end
