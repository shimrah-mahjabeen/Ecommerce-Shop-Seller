# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    name { Faker::Name.name }
    domain { Faker::Internet.email.sub('@', '.') }
    default_currency { 'USD' }
    platform { ApiKey::PLATFORMS.sample }

    trait :platform_a do
      platform { ApiKey::PLATFORMS_MAP[:platform_a] }
    end

    trait :platform_b do
      platform { ApiKey::PLATFORMS_MAP[:platform_b] }
    end
  end
end
