# frozen_string_literal: true

FactoryBot.define do
  factory :api_key do
    platform { ApiKey::PLATFORMS.sample }
    token { Faker::Crypto.md5 }

    trait :platform_a do
      platform { ApiKey::PLATFORMS_MAP[:platform_a] }
    end

    trait :platform_b do
      platform { ApiKey::PLATFORMS_MAP[:platform_b] }
    end
  end
end
