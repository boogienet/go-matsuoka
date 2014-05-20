require 'spec_helper'

describe :Initializer do
  it 'should setup database tables on the first run' do
    config = GoMatsuoka::Configuration.new
    GoMatsuoka::Initializer.new(config)

    config.is_first_run?.should == false
  end
end
