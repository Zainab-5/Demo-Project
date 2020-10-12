class Plan < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'
  has_and_belongs_to_many :features
  has_many :subscriptions, foreign_key: 'user_id'
  has_many :buyers, through: :subscriptions
  accepts_nested_attributes_for :features
end
