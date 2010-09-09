require 'nagios/connection'
require 'nagios/alerter'

describe Nagios::Alerter do
  describe "that's brand new" do
    
    before do
      @alerter = Nagios::Alerter.new
    end
    
    it "should have no defaults" do
      @alerter.hostname.should be_nil
      @alerter.service_name.should be_nil
      @alerter.return_code.should be_nil
      @alerter.status.should be_nil
    end
    
    it "should raise an error if you try to send an alert" do
      lambda { @alerter.send_alert }.should raise_error(ArgumentError)
    end
    
    it "should set values using the constructor" do
      @alerter = Nagios::Alerter.new(:hostname => "some.domain.com",
                                     :service_name => "my-alerter",
                                     :return_code => SendNsca::STATUS_OK,
                                     :status => "TEST")
      
      @alerter.hostname.should == "some.domain.com"
      @alerter.service_name.should == "my-alerter"
      @alerter.return_code.should == SendNsca::STATUS_OK
      @alerter.status.should == "TEST"
    end
    
    it "should set the hostname" do
      @alerter.hostname = "some.otherdomain.com"
      @alerter.hostname.should == "some.otherdomain.com"
    end
    
    it "should set the service name" do
      @alerter.service_name = "new-alerter"
      @alerter.service_name.should == "new-alerter"
    end
    
    it "should set the return code" do
      @alerter.return_code = SendNsca::STATUS_WARNING
      @alerter.return_code.should == SendNsca::STATUS_WARNING
    end
    
    it "should set the status" do
      @alerter.status = "NEWTEST"
      @alerter.status.should == "NEWTEST"
    end
  end
  
  describe "using Nagios::Connection" do
    before(:all) do
      Nagios::Connection.instance.host = "some.domain.com"
      Nagios::Connection.instance.port = 5667
    end
    
    before(:each) do
      @alerter = Nagios::Alerter.new(:hostname => "some.domain.com",
                                     :service_name => "new-alerter",
                                     :return_code => SendNsca::STATUS_OK,
                                     :status => "TEST")
    end
    
    it "should not error if not given a host and port" do
      @alerter.should_receive(:send_alert)
      lambda { @alerter.send_alert }.should_not raise_error(ArgumentError)
    end
  end
  
  describe "using the static method" do
    it "should error if run without any arguments" do
      lambda { Nagios::Alerter.send_alert }.should raise_error(ArgumentError)
    end
    
    it "should error if run without a host" do
      lambda { Nagios::Alerter.send_alert(:port => 5667,
                                          :hostname => "some.domain.com",
                                          :service_name => "my-alerter",
                                          :return_code => SendNsca::STATUS_OK,
                                          :status => "TEST")
      }.should raise_error(ArgumentError)
    end
    
    it "should error if run without a port" do
      lambda { Nagios::Alerter.send_alert(:host => "nagios.domain.com",
                                          :hostname => "some.domain.com",
                                          :service_name => "my-alerter",
                                          :return_code => SendNsca::STATUS_OK,
                                          :status => "TEST")
      }.should raise_error(ArgumentError)
    end
    
    it "should error if run without a hostname" do
      lambda { Nagios::Alerter.send_alert(:host => "nagios.domain.com",
                                          :port => 5667,
                                          :service_name => "my-alerter",
                                          :return_code => SendNsca::STATUS_OK,
                                          :status => "TEST")
      }.should raise_error(ArgumentError)
    end

    it "should error if run without a service name" do
      lambda { Nagios::Alerter.send_alert(:host => "nagios.domain.com",
                                          :port => 5667,
                                          :hostname => "some.domain.com",
                                          :return_code => SendNsca::STATUS_OK,
                                          :status => "TEST")
      }.should raise_error(ArgumentError)
    end
    
    it "should error if run without a return code" do
      lambda { Nagios::Alerter.send_alert(:host => "nagios.domain.com",
                                          :port => 5667,
                                          :hostname => "some.domain.com",
                                          :service_name => "my-alerter",
                                          :status => "TEST")
      }.should raise_error(ArgumentError)
    end
    
    it "should error if run without a status" do
      lambda { Nagios::Alerter.send_alert(:host => "nagios.domain.com",
                                          :port => 5667,
                                          :hostname => "some.domain.com",
                                          :service_name => "my-alerter",
                                          :return_code => SendNsca::STATUS_OK)
      }.should raise_error(ArgumentError)                               
    end
  end
end