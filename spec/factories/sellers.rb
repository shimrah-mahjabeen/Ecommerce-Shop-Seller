# frozen_string_literal: true

FactoryBot.define do
  factory :seller do
    customer_id { Faker::Number.number(digits: 13) }
    association :shop
  end
end
