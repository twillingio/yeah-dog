# # frozen_string_literal: true

require 'spec_helper'

RSpec.describe YeahDog::Configuration do
  describe '#service_name' do
    context 'when not explicitly set' do
      let(:configuration) { described_class.new }

      it "returns 'rails-app'" do
        subject = configuration.service_name

        expect(subject).to eq('rails-app')
      end
    end

    context 'when set' do
      it 'returns that value' do
        configuration = described_class.new.tap do |config|
          config.service_name = 'excellent-rails-app'
        end

        subject = configuration.service_name

        expect(subject).to eq('excellent-rails-app')
      end
    end
  end

  describe '#app_name' do
    it 'camelizes the service_name' do
      configuration = described_class.new.tap do |config|
        config.service_name = 'great-application'
      end

      subject = configuration.app_name

      expect(subject).to eq('GreatApplication')
    end
  end
end
