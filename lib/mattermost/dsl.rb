module Mattermost
  module DSL

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def get(endpoint_name, options = {})
        options[:resource] = self.resource_name
        create_api_method(:get, endpoint_name, options)
      end

      def post(endpoint_name, options = {})
        options[:resource] = self.resource_name
        create_api_method(:post, endpoint_name, options)
      end

      def put(endpoint_name, options = {})
        options[:resource] = self.resource_name
        create_api_method(:post, endpoint_name, options.merge(:http_method => :put))
      end

      def delete(endpoint_name, options = {})
        create_api_method(:delete, endpoint_name, options)
      end

      private

      # /teams/name/:first_name/exists/:last_name
      # arg should be :first_name, :last_name (in the order they appear)
      def create_api_method(http_method, method_name, options = {})
        options = normalize_options(options)
        options[:http_method] ||= http_method
        define_api_method(method_name, options)
      end

      def define_api_method(method_name, opts)
        if opts[:as] == :self
          define_singleton_method(method_name) do |*args|
            endpoint = EndpointBuilder.new(self, method_name, args, opts)
            request = Client.send(opts[:http_method], "#{Mattermost.configuration.raw_host}/api/v4#{endpoint.endpoint}", endpoint.request_options)
            request
          end
        else
          define_method(method_name) do |*args|
            endpoint = EndpointBuilder.new(self, method_name, args, opts)
            request = Client.send(opts[:http_method], "#{Mattermost.configuration.raw_host}/api/v4#{endpoint.endpoint}", endpoint.request_options)
            request
          end
        end
      end

      def normalize_options(options)
        options[:args] ||= []
        options
      end

    end

  end
end


