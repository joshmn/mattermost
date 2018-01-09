module Mattermost
  class EndpointBuilder

    def initialize(resource, method_name, args, options)
      @resource = resource
      @method_name = method_name
      @args = args
      @options = options
    end

    def interpolated_endpoint
      raw = raw_endpoint
      route_params = raw.scan(%r{(:\w*)}).flatten
      route_params.each do |route_param|
        rp = route_param[1..-1]
        if @resource.respond_to?(rp.to_sym)
          raw.gsub!(route_param, @resource.send(rp.to_sym))
        elsif parameters[rp.to_sym]
          raw.gsub!(route_param, parameters[rp.to_sym])
        elsif endpoint_args_map[rp.to_sym]
          raw.gsub!(route_param, endpoint_args_map[rp.to_sym])
        end
      end
      unless query_params.empty?
        raw += "?#{URI.encode_www_form(query_params)}"
      end
      raw
    end

    def request_options
      if request_body
        return {:body => request_body.to_json}
      end
      {}
    end

    alias_method :endpoint, :interpolated_endpoint

    private

    def raw_endpoint
      if as == :member
        return "/#{@options[:resource].plural}/:#{@options[:resource].param_key}/#{@method_name}" if @options[:endpoint].nil?
        if @options[:endpoint] == ''
          return "/#{@options[:resource].plural}/:#{@options[:resource].param_key}"
        elsif @options[:endpoint].to_s[0] != '/'
          return "/#{@options[:resource].plural}/:#{@options[:resource].param_key}/#{@options[:endpoint]}"
        end
      elsif as == :self
        return "/#{@options[:resource].plural}/#{@method_name}" if @options[:endpoint].nil?
        if @options[:endpoint] == ''
          return "/#{@options[:resource].plural}"
        elsif @options[:endpoint].to_s[0] != '/'
          return "/#{@options[:resource].plural}/#{@options[:endpoint]}"
        end
      end
    end

    def parameters
      if @args[0].is_a?(Hash)
        @args[0]
      else
        extract_args
      end
    end

    def args_from_options
      if @options[:args].is_a?(Symbol)
        [@options[:args]]
      else
        @options[:args]
      end
    end

    def endpoint_args_map
      map = {}
      raw_endpoint.scan(%r{(:\w*)}).flatten.map { |p| p[1..-1].to_sym }.each_with_index do |arg, ind|
        map[arg] = @args[ind]
      end
      map
    end

    def extract_args
      arg_map = {}
      args_from_options.each_with_index do |arg, ind|
        arg_map[arg] = @args[ind]
      end
      arg_map
    end

    def supports_query_params?
      @options[:http_method] == :get
    end

    def query_params
      return {} unless supports_query_params?
      return {} if @args.empty?
      if @args[0].is_a?(Hash)
        return @args[0]
      end
      {}
    end

    def body_map
      if @options[:body]
        arg_map = {}
        [@options[:body]].each_with_index do |arg, ind|
          arg_map[arg] = @args[ind]
        end
        return arg_map
      end
    end

    def request_body
      if @options[:body]
        return body_map
      end
      if @args[0].is_a?(Hash)
        return @args[0]
      end
      if @args[0].is_a?(String) && @args.is_a?(Array)
        if as == :self
          return @args
        end
      end
      nil
    end

    def as
      @options[:as]
    end
  end
end