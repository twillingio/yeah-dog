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
      configuration = YeahDog::Configuration.new.tap do |config|
        config.service_name = 'yeah-dog-rails-app'
      end
      allow(YeahDog).to receive(:configuration).and_return(configuration)

      described_class.apply!

      expect(datadog_configuration).to have_received(:service=).with('yeah-dog-rails-app').once
    end

    it 'sets the cache service name to [service-name]-cache' do
      configuration = YeahDog::Configuration.new.tap do |config|
        config.service_name = 'yeah-dog-rails-app'
      end
      allow(YeahDog).to receive(:configuration).and_return(configuration)

      described_class.apply!

      expect(tracing_object)
        .to have_received(:instrument)
        .with(:active_support, cache_service: 'yeah-dog-rails-app-cache')
    end
  end
end
