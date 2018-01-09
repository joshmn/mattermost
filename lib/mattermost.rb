require 'mattermost/version'
require 'mattermost/client'
require 'mattermost/dsl'
require 'mattermost/endpoint_builder'
require 'mattermost/resource_name'
require 'mattermost/resources/base'
require 'mattermost/resources/team'
require 'mattermost/resources/user'

module Mattermost

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Config.new
    yield(configuration)
  end

  class Config
    attr_accessor :server, :protocol, :username, :password

    def initialize
      @server = ""
      @protocol = "https"
      @username = ""
      @password = ""
    end

    def raw_host
      "#{Mattermost.configuration.protocol}://#{Mattermost.configuration.server}"
    end

  end

  def self.connect!
    Client.connect!
  end

end
