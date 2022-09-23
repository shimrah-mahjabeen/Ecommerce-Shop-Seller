# frozen_string_literal: true

class Shop < ApplicationRecord
  acts_as_paranoid

  has_many :sellers, dependent: :destroy

  validates :domain, presence: true, uniqueness: true
  validates :platform, presence: true

  scope :platform_a, -> { by_platform(ApiKey::PLATFORMS_MAP[:platform_a]) }
  scope :platform_b, -> { by_platform(ApiKey::PLATFORMS_MAP[:platform_b]) }

  scope :by_platform, -> (platform) { where(platform: platform) }
end
