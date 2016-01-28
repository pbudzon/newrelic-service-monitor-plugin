# New Relic Service Monitoring Plugin

This plugin is meant to monitor any background services running on your server.

## Requirements
* (New Relic)[https://newrelic.com] account
* Ruby 1.8.7 or higher
* Ruby Gems
* make
* On ubuntu, you'll also need to install `ruby-dev` package to build the `json` gem used by NewRelic SDK.

### Packages required on Ubuntu
* ruby 
* ruby-dev
* make

## Installation

* Create the GEM (see *Building the GEM* below)
* `gem install newrelic_service_monitor_plugin-1.0.2.gem`
* `cd $(dirname $(gem which newrelic_service_monitor_plugin))/../config/`
* `cp template_newrelic_plugin.yml newrelic_plugin.yml`
* edit `newrelic_plugin.yml` to match your configuration (see below)

### Configuration 
In the `config\newrelic_plugin.yml`:

* replace `YOUR_LICENSE_KEY_HERE` with your New Relic License Key
* under `agents -> service_monitor` fill in:
    * `name` - this will be a name that you'll see in New Relic, usually the host's name
    * `processes` - list of key -> value elements where key is the name to be shown in New Relic, value is the command to be
    executed to check the status. Status of the process is determined by this command: returning exit code 0 shows process as
    running, returning anything else shows process as not running.
    
#### Example configuration
```
agents:
    service_monitor:
        name: 'Testing'
        processes:
            nexus: "service nexus status"
            php-fpm: "service php-fpm status"
```
 
## Running
For production use (if you installed the gem), use the daemon (should be in your $PATH): `newrelic_service_monitor_plugin.daemon start`

Daemon supports standard commands: `start`, `stop`, `restart`, `status`. 
It also monitors the plugin and restarts it if needed.

That's it! Go to NewRelic -> Plugins and you should see your instance reporting data in a couple of minutes.

### Reported values
Status of each process will be reported to New Relic using NRPE-compatible values:

* 0 - ok
* 1 - warning (not used)
* 2 - error (checked process not running)

The metrics in New Relic will be called `Compoments/{process name}/Running[]`. Use "Average value" when analyzing the metrics.
You'll probably need to adjust the default dashboard showing the statistics to show information about your process.

## Development

### Development requirements
* Rubygems 1.8 or higher
* Bundler 1.3.0 or higher

### Development installation
* run `bundle install`
* copy `config\template_newrelic_plugin.yml` to `config\newrelic_plugin.yml`
* fill in your configuration as described below

### Building the GEM
* Modify the `spec.version` in newrelic_service_monitor_plugin.gemspec
* `gem build newrelic_service_monitor_plugin.gemspec`
