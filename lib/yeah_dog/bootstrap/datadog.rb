# frozen_string_literal: true

module YeahDog
  module Bootstrap
    class Datadog
      class << self
        def apply!
          apply_global_configuration!
        end

        private

        def apply_global_configuration!
          ::Datadog.configure do |c|
            c.service = YeahDog.configuration.service_name
          end
        end
      end
    end
  end
end
