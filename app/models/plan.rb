class Plan < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'
  has_many :features
  has_many :subscriptions, foreign_key: 'user_id'
  has_many :buyers, through: :subscriptions
end
