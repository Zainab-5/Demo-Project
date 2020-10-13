class Feature < ApplicationRecord
  has_and_belongs_to_many :plans
  before_destroy {|feature| feature.plans.clear}
end
