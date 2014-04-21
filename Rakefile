require "bundler/gem_tasks"
require 'active_record'
load 'lib/gomatsuoka.rb'

namespace :db do
  def setup
    @configuration = GoMatsuoka::Configuration.new
  end
  task :configure_connection do
    @configuration = GoMatsuoka::Configuration.new
    @initializer = GoMatsuoka::Application::Database.new(@configuration)
  end

  task :migrate => :configure_connection do
    migrations_dir = "./lib/initializer/migrations"
    puts migrations_dir
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate migrations_dir
  end
  task :drop => :configure_connection do
    ActiveRecord::Tasks::DatabaseTasks.drop_all
  end
end
