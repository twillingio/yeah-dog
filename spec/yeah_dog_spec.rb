# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YeahDog do
  it 'has a version number' do
    expect(YeahDog::VERSION).not_to be nil
  end

  describe '.configuration' do
    it 'returns configuration' do
      subject = described_class.configuration

      expect(subject).to be_instance_of YeahDog::Configuration
      expect(subject).to have_attributes(app_name: YeahDog::Configuration::DEFAULT_APP_NAME)
    end
  end

  describe '.configure' do
    it 'permits configuring YeahDog.configuration' do
      expect do
        described_class.configure do |c|
          c.app_name = 'SweetApp'
        end
      end.to change { described_class.configuration.app_name }
        .from(YeahDog::Configuration::DEFAULT_APP_NAME)
        .to('SweetApp')
    end
  end
end
