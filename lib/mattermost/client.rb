require 'httparty'

module Mattermost
  class Client
    include HTTParty

    def self.connect!
      req = HTTParty.post("#{Mattermost.configuration.protocol}://#{Mattermost.configuration.server}/api/v4/users/login", :body => {:login_id => Mattermost.configuration.username, :password => Mattermost.configuration.password}.to_json)
      binding.pry
      if req.success?
        class_eval do
          base_uri "#{Mattermost.configuration.protocol}://#{Mattermost.configuration.server}/api/v4"
          headers 'Cookie' => req.headers['set-cookie'], 'X-Requested-With' => 'XMLHttpRequest'
        end
      end
    end

  end
end