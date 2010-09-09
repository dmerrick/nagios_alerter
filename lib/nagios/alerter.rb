require 'rubygems'
require 'send_nsca'

module Nagios
  class Alerter

    attr_accessor :hostname
    attr_accessor :service_name
    attr_accessor :return_code
    attr_accessor :status

    def initialize(args = {})
      @hostname     = args[:hostname]
      @service_name = args[:service_name]
      @return_code  = args[:return_code]
      @status       = args[:status]
    end

    def send_alert(args = {})
      # host and port can be passed as parameters or set using Nagios::Connection
      connection = connection_params(args[:host], args[:port])

      # check the parameters if we're missing any variables
      check_args(args) if [@hostname, @service_name, @return_code, @status].any? {|var| var.nil? }

      hostname     = args[:hostname]     || @hostname
      service_name = args[:service_name] || @service_name
      return_code  = args[:return_code]  || @return_code
      status       = args[:status]       || @status

      config = {
                :nscahost => connection[:host],
                :port => connection[:port],
                :hostname => hostname,
                :service => service_name,
                :return_code => return_code,
                :status => status
      }

      nsca_connection = SendNsca::NscaConnection.new(config)
      nsca_connection.send_nsca
    end

    # if you don't want to create a Nagios::Alerter object, you can call Nagios::Alerter.send_alert
    def self.send_alert(args)
      if [:host, :port, :hostname, :service_name, :return_code, :status].any? {|key| !args.has_key?(key) }
        raise ArgumentError, "You must provide all alert details"
      end

      config = {
                :nscahost => args[:host],
                :port => args[:port],
                :hostname => args[:hostname],
                :service => args[:service_name],
                :return_code => args[:return_code],
                :status => args[:status]
      }

      nsca_connection = SendNsca::NscaConnection.new(config)
      nsca_connection.send_nsca
    end

    private

      # check that we have the Nagios server details
      def connection_params(host, port)
  
        params = {}
  
        if !host.nil?
          params[:host] = host
        elsif !Nagios::Connection.instance.host.nil?
          params[:host] = Nagios::Connection.instance.host
        else
          raise ArgumentError, "You must provide a Nagios host or use Nagios::Connection"
        end

        if !port.nil?
          params[:port] = port
        elsif !Nagios::Connection.instance.port.nil?
          params[:port] = Nagios::Connection.instance.port
        else
          raise ArgumentError, "You must provide a Nagios port or use Nagios::Connection"
        end

        return params
      end

      # a method to verify that all necessary requirements are satisfied
      def check_args(hash)
        if !hash.include? :hostname
          raise ArgumentError, "You must provide a hostname"
        elsif !hash.include? :service_name
          raise ArgumentError, "You must provide a service name"
        elsif !hash.include? :return_code
          raise ArgumentError, "You must provide a return code"
        elsif !hash.include? :status
          raise ArgumentError, "You must provide a status"
        end
      end

  end
end