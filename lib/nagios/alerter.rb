require 'send_nsca'

module Nagios
  class Alerter

    def send_alert(args)
      host, port = connection_params(args[:host], args[:port])
      
      # FIXME: this method is not yet finished
      puts "host: #{host}"
      puts "port: #{port}"
      
    end
  
    private
  
      # check that we have the Nagios server details
      def connection_params(host, port)
        
        params = []
        
        if !host.nil?
          params << host
        elsif !Nagios::Connection.instance.host.nil?
          params << Nagios::Connection.instance.host
        else
          raise ArgumentError, "You must provide a Nagios host or use Nagios::Connection"
        end
      
        if !port.nil?
          params << port
        elsif !Nagios::Connection.instance.port.nil?
          params << Nagios::Connection.instance.port
        else
          raise ArgumentError, "You must provide a Nagios port or use Nagios::Connection"
        end
      
        return params
      end
    
  end
end