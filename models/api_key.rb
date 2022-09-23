# frozen_string_literal: true

class ApiKey < ApplicationRecord
  acts_as_paranoid

  validates :platform, presence: true, uniqueness: true

  validates :platform, inclusion: { in: PLATFORMS }

  PLATFORMS_MAP = {
    platform_a: 'platform_a',
    platform_b: 'platform_b'
  }.with_indifferent_access.freeze

  PLATFORMS = PLATFORMS_MAP.values.freeze
end
