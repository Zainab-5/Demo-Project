class Plan < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'
  has_and_belongs_to_many :features
  has_many :subscriptions, dependent: :delete_all
  has_many :buyers, through: :subscriptions, foreign_key: 'user_id'
  accepts_nested_attributes_for :features
  before_destroy {|plan| plan.features.clear}
end
