# frozen_string_literal: true

class Buyer < User
  has_many :subscriptions, foreign_key: 'user_id'
  has_many :plans, through: :subscriptions
  has_many :transactions, foreign_key: 'user_id'
end
