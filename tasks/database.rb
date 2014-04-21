require 'active_record'

namespace :db do
  task :load_config do

  end
  namespace :create do
    task :all => :load_config do

    end
  end
end
