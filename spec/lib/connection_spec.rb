require 'nagios/connection'

describe Nagios::Connection do
  it "should mixin the Singleton module" do
    included_modules = (class << Nagios::Connection.instance; self; end).send :included_modules
    included_modules.should include(Singleton)
  end

  it "should only have one instance" do
    a = Nagios::Connection.instance
    b = Nagios::Connection.instance
    a.should == b
  end
  
  it "should have no defaults" do
    Nagios::Connection.instance.host.should be_nil
    Nagios::Connection.instance.port.should be_nil
  end
  
  it "should set the host and port" do
    Nagios::Connection.instance.host = "some.domain.com"
    Nagios::Connection.instance.port = 5667
    
    Nagios::Connection.instance.host.should == "some.domain.com"
    Nagios::Connection.instance.port.should == 5667
  end
end