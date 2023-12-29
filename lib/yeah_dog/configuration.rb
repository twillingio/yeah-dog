# frozen_string_literal: true

require 'active_support/all'

module YeahDog
  class Configuration
    DEFAULT_SERVICE_NAME = 'rails-app'

    attr_accessor :service_name

    def initialize
      set_defaults
    end

    def app_name
      underscored_service_name.camelize
    end

    private

    def set_defaults
      self.service_name = DEFAULT_SERVICE_NAME
    end

    def underscored_service_name
      @_underscored_service_name ||= service_name.gsub('-', '_')
    end
  end
end
