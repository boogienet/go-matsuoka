require 'active_record'
require 'yaml'

module GoMatsuoka
  class Application
    class Database 
      def initialize(configuration)
        dbconfig = {
          :adapter => "sqlite3",
          :database => "#{configuration.database}",
          :pool => 5,
          :timeout => 5000,
        }
        ActiveRecord::Base.logger = Logger.new STDOUT
        ActiveRecord::Base.establish_connection(dbconfig)
      end
    end
  end
end
