# # frozen_string_literal: true

module YeahDog
  class Configuration
    DEFAULT_APP_NAME = 'rails-app'.freeze

    def initialize; end

    attr_writer :app_name

    def app_name
      return @app_name if defined? @app_name

      DEFAULT_APP_NAME
    end
  end
end
