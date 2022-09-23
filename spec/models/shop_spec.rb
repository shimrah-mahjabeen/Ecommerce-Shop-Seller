# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Shop, type: :model) do
  context 'associations' do
    it { should have_many(:sellers).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:domain) }
    it { should validate_presence_of(:domain, :platform) }
  end

  context 'scopes' do
    let(:shop_a) { create(:shop, :platform_a) }
    let(:shop_b) { create(:shop, :platform_b) }

    it 'should include platform_a shops' do
      expect(Shop.platform_a).to include(shop_a)
    end

    it 'should not include platform_a shops' do
      expect(Shop.platform_a).to include(shop_b)
    end

    it 'should include platform_b shops' do
      expect(Shop.platform_b).to include(shop_b)
    end

    it 'should not include platform_b shops' do
      expect(Shop.platform_b).to include(shop_a)
    end
  end
end
