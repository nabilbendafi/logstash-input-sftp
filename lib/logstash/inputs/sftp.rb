# encoding: utf-8
require "concurrent"

require "logstash/inputs/base"
require "logstash/inputs/file"
require "logstash/namespace"
require "stud/interval"

require "fileutils"

# This Logstash input plugin allows you to retrieve data over SFTP
# protocol
# 
# Remote files are synced locally and send to LogStash::Inputs::File plugin
#
# The config should look like this:
#
# [source,ruby]
# ----------------------------------
# input {
#   sftp {
#     username => "me"
#     password => "secret"
#     host => "localhost.localdomain"
#     port => 2222
#     remote_path => "/var/siem_feeder/*.log"
#     local_path => "/var/archive/"
#     file_input_options => {
#      # This options override logstash-input-file ones
#      start_position => "beginning"
#     }
#   }
# }
#
# output {
#   stdout {
#     codec => rubydebug
#   }
# }
# ----------------------------------
#

class LogStash::Inputs::SFTP < LogStash::Inputs::Base
  config_name "sftp"

  default :codec, "plain"

  # Login credentials on SFTP server.
  config :username, :validate => :string, :default => "username"
  config :password, :validate => :password, :default => "password"

  # SFTP server hostname (or ip address)
  config :host, :validate => :string, :required => true
  # and port number.
  config :port, :validate => :number, :default => 22

  # Remote SFTP path and local path
  config :remote_path, :validate => :path, :required => true
  config :local_path, :validate => :path, :required => true

  # Interval to pull remote data (in seconds).
  config :interval, :validate => :number, :default => 60


  public
  def register
    @logger.info("Registering SFTP Input",
                 :username => @username, :password => @password,
                 :host => @host, :port => @port,
                 :remote_path => remote_path, :local_path => @local_path,
                 :interval => @interval)

    # Register LogStash::Inputs::File to follow :local_path
    file_configuration = {:path => @local_path, :type => @type}
    if defined?(file_input_options)
      file_configuration.merge(file_input_options)
    end
    file_input = LogStash::Plugin.lookup("input", "file").new(file_configuration)
    file_input.register
  end # def register

  public
  def run(queue)
    Stud.interval(@interval) do
      @remote_path.each do |path|
        start = Time.now
        duration = Time.now - start
    
        @logger.debug? && @logger.debug("Sync path", :path => @path,
                                        :local_path => @local_path)
      end
    end
  end # def run

end # class LogStash::Inputs::SFTP
