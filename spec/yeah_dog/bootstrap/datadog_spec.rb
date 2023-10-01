# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YeahDog::Bootstrap::Datadog do
  let(:datadog_configuration) { spy }

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
  end
end
