# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nagios_alerter}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dana Merrick"]
  s.date = %q{2010-09-09}
  s.description = %q{Send a heartbeat to a Nagios server}
  s.email = %q{dana.merrick@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc", "lib/nagios/alerter.rb", "lib/nagios/connection.rb", "lib/nagios_alerter.rb", "tasks/rspec.rake"]
  s.files = ["LICENSE", "README.rdoc", "Rakefile", "lib/nagios/alerter.rb", "lib/nagios/connection.rb", "lib/nagios_alerter.rb", "spec/lib/alerter_spec.rb", "spec/lib/connection_spec.rb", "spec/spec.opts", "tasks/rspec.rake", "Manifest", "nagios_alerter.gemspec"]
  s.homepage = %q{http://github.com/dmerrick/nagios_alerter}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Nagios_alerter", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nagios_alerter}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Send a heartbeat to a Nagios server}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<send_nsca>, [">= 0.4.11"])
    else
      s.add_dependency(%q<send_nsca>, [">= 0.4.11"])
    end
  else
    s.add_dependency(%q<send_nsca>, [">= 0.4.11"])
  end
end
