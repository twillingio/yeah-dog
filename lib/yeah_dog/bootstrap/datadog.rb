# frozen_string_literal: true

module YeahDog
  module Bootstrap
    class Datadog
      class << self
        def apply!
          apply_global_configuration!
          apply_caching_configuration!
          apply_database_configuration!
        end

        private

        def apply_global_configuration!
          ::Datadog.configure do |c|
            c.service = configuration.service_name
          end
        end

        def apply_caching_configuration!
          ::Datadog.configure do |c|
            c.tracing.instrument :active_support, cache_service: caching_service_name
          end
        end

        def apply_database_configuration!
          ::Datadog.configure do |c|
            c.tracing.instrument :active_record, service_name: database_service_name
            c.tracing.instrument :pg, service_name: database_service_name
          end
        end

        def configuration
          YeahDog.configuration
        end

        def caching_service_name
          @_caching_service_name ||= "#{configuration.service_name}-cache"
        end

        def database_service_name
          @_database_service_name ||= "#{configuration.service_name}-db"
        end
      end
    end
  end
end
