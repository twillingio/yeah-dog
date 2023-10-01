# frozen_string_literal: true

require_relative 'yeah_dog/version'

require 'ddtrace'
require 'statsd-instrument'

module YeahDog
  class Error < StandardError; end
end
