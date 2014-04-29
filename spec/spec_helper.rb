require 'rspec'
require 'gomatsuoka'
require 'application'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  ENV['GM_ENV']        = 'blah'
end
