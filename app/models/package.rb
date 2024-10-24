class Package < ApplicationRecord
  PACKAGES = %w(10 50 500).freeze

  validates :name, inclusion: { in: PACKAGES }
end
