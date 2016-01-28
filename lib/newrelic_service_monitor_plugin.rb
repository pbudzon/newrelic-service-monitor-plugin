#! /usr/bin/env ruby

require "newrelic_plugin"

module ServiceMonitoringAgent

  class Agent < NewRelic::Plugin::Agent::Base

    agent_guid "com.cni.service_monitor"
    agent_version "1.0.1"
    agent_config_options :name, :processes
    agent_human_labels("Service monitor") { "#{name}" }

    def poll_cycle
      processes.each do |name, process|
        puts "Checking service " +name +": "+ process
        if system(process)
          puts "Running"
          report_metric name + "/Running", "", 0
        else
          puts "Not running"
          report_metric name + "/Running", "", 2
        end
      end
    end

  end

  #
  # Register this agent with the component.
  # The ExampleAgent is the name of the module that defines this
  # driver (the module must contain at least three classes - a
  # PollCycle, a Metric and an Agent class, as defined above).
  #
  NewRelic::Plugin::Setup.install_agent :service_monitor, ServiceMonitoringAgent

  # Change the path to the config file for absolute one, otherwise daemonizing doesn't work
  NewRelic::Plugin::Config.config_file=File.dirname(__FILE__) + "/../config/newrelic_plugin.yml"

  #
  # Launch the agent; this never returns.
  #
  NewRelic::Plugin::Run.setup_and_run

end
