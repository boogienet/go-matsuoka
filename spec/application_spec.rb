require 'spec_helper.rb'

describe :Application do
  it "should load a development environment by default" do
    GoMatsuoka.env.include?('development')
  end
end
