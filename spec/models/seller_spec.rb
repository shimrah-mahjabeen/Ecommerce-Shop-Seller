# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Seller, type: :model) do
  context 'associations' do
    it { should belong_to(:shop) }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:customer_id).scoped_to(:shop_id) }
  end
end
