require 'spec_helper.rb'

describe :Configuration do
  it 'should create the correct logfile path based off the environment variable' do
    configuration = GoMatsuoka::Configuration.new
    configuration.log_file.should == File.join(GoMatsuoka.data_dir, 'blah.log')
  end
  it 'should create the correct database path based off the environment variable' do
    configuration = GoMatsuoka::Configuration.new
    configuration.database.should == File.join(GoMatsuoka.data_dir, 'blah.sqlite3')
  end
  it 'should be the first time run if the database has not be created' do
    configuration = GoMatsuoka::Configuration.new
    configuration.is_first_run?.should == true
  end
end
