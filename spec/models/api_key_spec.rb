# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(ApiKey, type: :model) do
  describe 'constants' do
    it 'should ensure that platforms map is defined' do
      expect(described_class::PLATFORMS_MAP).not_to(be_nil)
    end

    it 'should ensure that platforms are present with valid values' do
      expect(described_class::PLATFORMS).not_to(be_nil)
      expect(described_class::PLATFORMS).to(eql(described_class::PLATFORMS_MAP.values))
    end
  end

  describe 'validations' do
    context 'platform' do
      let!(:api_key) { create(:api_key) }

      it { should validate_presence_of(:platform) }
      it { should validate_uniqueness_of(:platform) }
      it { should validate_inclusion_of(:platform).in_array(described_class::PLATFORMS) }
    end
  end
end
