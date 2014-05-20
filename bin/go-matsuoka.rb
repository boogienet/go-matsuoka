#!/usr/bin/env ruby

load 'gomatsuoka.rb'
require 'console'

require 'optparse'
require 'irb'
require 'irb/completion'

# app = GoMatsuoka::Application.new
# puts "Application #{app} configured? #{app.configured?}"
# puts "Application #{app} initialized? #{app.initialized?}"
OptionParser.new do |opts|
  opts.banner = 'Usage: go-matsuoka [options]'

  opts.on('-e', '--environment ENV', 'Environment to run go-matsuoka in (defaults to development)') do |environment|
    GoMatsuoka.env = environment
  end

end.parse!

GoMatsuoka::Console._start
