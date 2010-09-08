require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('nagios_alerter', '0.1.0') do |p|
  p.description    = "Send a heartbeat to a Nagios server"
  p.url            = "http://github.com/dmerrick/nagios_alerter"
  p.author         = "Dana Merrick"
  p.email          = "dana.merrick@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ["send_nsca >=0.4.11"]
  p.development_dependencies = []
end

# load any other rake tasks
Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }