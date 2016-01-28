# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "newrelic_service_monitor_plugin"
  spec.version       = '1.0.2'
  spec.authors       = ["Paulina Budzon"]
  spec.email         = ["paulina.budzon@gmail.com"]

  spec.summary       = "Plugin for NewRelic to monitor background services"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = ["lib/newrelic_service_monitor_plugin.rb", "config/template_newrelic_plugin.yml"]
  spec.bindir        = "bin"
  spec.executables   = ["newrelic_service_monitor_plugin.daemon"]

  spec.add_development_dependency "bundler", "~> 1.11"

  spec.add_runtime_dependency 'daemons', '~> 1.2'
  spec.add_runtime_dependency 'newrelic_plugin', '~> 1.3'
end
