#!/usr/bin/env ruby

require 'gomatsuoka'
require 'optparse'
require 'irb'
require 'irb/completion'

a = GoMatsuoka::Application.new
puts "Application #{a} configured? #{a.configured?}"
puts "Application #{a} initialized? #{a.initialized?}"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: go-matsuoka [options]"

  opts.on("-c", "--config FILE", "Configuration file") do |config|
    options[:config_file] = config
  end

end.parse!

@console = IRB
@console.start
