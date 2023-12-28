# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YeahDog::Bootstrap::Datadog do
  let(:instrument_method) { spy }
  let(:tracing_object) do
    spy.tap do |tracing_spy|
      allow(tracing_spy).to receive(:instrument).and_return(instrument_method)
    end
  end
  let(:datadog_configuration) do
    spy.tap do |configuration_spy|
      allow(configuration_spy).to receive(:tracing).and_return(tracing_object)
    end
  end

  before do
    allow(Datadog).to receive(:configure).and_yield(datadog_configuration)
  end

  describe '.apply!' do
    it 'sets the Datadog default service' do
      configure_service(name: 'yeah-dog-rails-app')

      described_class.apply!

      expect(datadog_configuration).to have_received(:service=).with('yeah-dog-rails-app').once
    end

    it 'sets the cache service name to [service-name]-cache' do
      configure_service(name: 'yeah-dog-rails-app')

      described_class.apply!

      expect(tracing_object)
        .to have_received(:instrument)
        .with(:active_support, cache_service: 'yeah-dog-rails-app-cache')
    end

    context 'database instruments' do
      it 'instruments ActiveRecord as [service-name]-db' do
        configure_service(name: 'yeah-dog-rails-app')

        described_class.apply!

        expect(tracing_object)
          .to have_received(:instrument)
          .with(:active_record, service_name: 'yeah-dog-rails-app-db')
      end

      it 'instruments pg as [service-name]-db' do
        configure_service(name: 'yeah-dog-rails-app')

        described_class.apply!

        expect(tracing_object)
          .to have_received(:instrument)
          .with(:pg, service_name: 'yeah-dog-rails-app-db')
      end
    end

    context 'HTTP libraries' do
      described_class::HTTP_CLIENTS_TO_SPLIT_BY_DOMAIN.each do |http_instrument|
        it "enables split_by_domain for #{http_instrument}" do
          configure_service(name: 'yeah-dog-rails-app')

          described_class.apply!

          expect(tracing_object).to have_received(:instrument).with(http_instrument, split_by_domain: true)
        end
      end
    end
  end

  def configure_service(name:)
    configuration = YeahDog::Configuration.new.tap do |config|
      config.service_name = name
    end
    allow(YeahDog).to receive(:configuration).and_return(configuration)
  end
end
