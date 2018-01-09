module Mattermost
  class ResourceName

    attr_reader :klass
    def initialize(klass)
      @klass = if klass.name.index("::")
                 klass.name.split("::").last
               else
                 klass.name
               end
    end

    def singular
      @klass.downcase
    end

    def plural
      "#{@klass}s".downcase
    end

    def path
      plural.downcase
    end

    def param_key
      "#{singular}_id".downcase.to_sym
    end

  end
end