module Mattermost
  class BaseResource

    include Mattermost::DSL

    attr_reader :id
    def initialize(id)
      @id = id
    end

    def self.find(id)
      new(id)
    end

    def self.resource_name
      ResourceName.new(self)
    end

  end
end