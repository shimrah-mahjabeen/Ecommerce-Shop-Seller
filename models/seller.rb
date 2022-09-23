# frozen_string_literal: true

class Seller < ApplicationRecord
  acts_as_paranoid

  belongs_to :shop

  validates :customer_id, uniqueness: { scope: :shop_id }
end
