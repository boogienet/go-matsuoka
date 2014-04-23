#!/usr/bin/env ruby

# require 'gomatsuoka'
require 'console'

require 'optparse'
require 'irb'
require 'irb/completion'

#app = GoMatsuoka::Application.new
#puts "Application #{app} configured? #{app.configured?}"
#puts "Application #{app} initialized? #{app.initialized?}"
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: go-matsuoka [options]"

  opts.on("-c", "--config FILE", "Configuration file") do |config|
    options[:config_file] = config
  end

end.parse!

GoMatsuoka::Console._start
