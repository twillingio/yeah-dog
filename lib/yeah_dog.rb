# frozen_string_literal: true

require_relative 'yeah_dog/version'
require_relative 'yeah_dog/configuration'

require 'datadog/statsd'
require 'ddtrace'
require 'statsd-instrument'

module YeahDog
  class Error < StandardError; end

  class << self
    def configuration
      @_configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
