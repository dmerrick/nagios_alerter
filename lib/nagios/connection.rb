require 'singleton'

module Nagios
  class Connection
    include Singleton
    
    attr_accessor :host
    attr_accessor :port
    
  end
end