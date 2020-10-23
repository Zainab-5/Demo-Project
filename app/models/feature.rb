class Feature < ApplicationRecord
  has_and_belongs_to_many :plans
  has_many :usages
  before_destroy { |feature| feature.plans.clear }
  validates :unit_price, :max_limit, presence: true
end
